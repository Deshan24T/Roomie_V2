package mtr.group4.Roomie.controller;

import mtr.group4.Roomie.model.Room;
import mtr.group4.Roomie.service.RoomService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Controller
@RequestMapping("/room")
public class RoomController {

    private final RoomService roomService;

    @Value("${app.upload.path}")
    private String uploadPath;

    public RoomController(RoomService roomService) {
        this.roomService = roomService;
    }

    // ── Public ────────────────────────────────────────────────────────────────

    @GetMapping("/list")
    public String list(Model model, @RequestParam(required = false) String type) {
        if (type != null && !type.isEmpty()) {
            model.addAttribute("rooms", roomService.getRoomsByType(type));
            model.addAttribute("selectedType", type);
        } else {
            model.addAttribute("rooms", roomService.getAllRooms());
        }
        return "room/list";
    }

    @GetMapping("/detail/{id}")
    public String detail(@PathVariable String id, Model model) {
        Optional<Room> room = roomService.getRoomById(id);
        if (!room.isPresent()) return "redirect:/room/list";
        model.addAttribute("room", room.get());
        return "room/detail";
    }

    // ── Admin only ────────────────────────────────────────────────────────────

    @GetMapping("/manage")
    public String manage(Model model, HttpSession session) {
        if (session.getAttribute("loggedAdmin") == null) return "redirect:/admin/login";
        model.addAttribute("rooms", roomService.getAllRooms());
        return "admin/manage-rooms";
    }

    // --- Add Room ---

    @GetMapping("/add")
    public String addForm(HttpSession session) {
        if (session.getAttribute("loggedAdmin") == null) return "redirect:/admin/login";
        return "admin/add-room";
    }

    @PostMapping("/add")
    public String addRoom(@RequestParam String roomNumber, @RequestParam String type,
                          @RequestParam double pricePerNight, @RequestParam int capacity,
                          @RequestParam String description, @RequestParam String amenities,
                          @RequestParam(required = false) MultipartFile image,
                          HttpSession session, RedirectAttributes ra) {
        if (session.getAttribute("loggedAdmin") == null) return "redirect:/admin/login";

        List<String> amenList = Arrays.asList(amenities.split("\\|"));
        String imageFileName = saveUploadedImage(image);

        Room room = new Room(null, roomNumber, type, pricePerNight, capacity, description,
                amenList, "AVAILABLE", java.time.LocalDate.now().toString(), imageFileName);
        roomService.addRoom(room);
        ra.addFlashAttribute("flash_success", "Room added successfully!");
        return "redirect:/room/manage";
    }

    // --- Edit Room ---

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable String id, HttpSession session, Model model) {
        if (session.getAttribute("loggedAdmin") == null) return "redirect:/admin/login";
        Optional<Room> room = roomService.getRoomById(id);
        if (!room.isPresent()) return "redirect:/room/manage";
        model.addAttribute("room", room.get());
        return "admin/edit-room";
    }

    @PostMapping("/edit/{id}")
    public String editRoom(@PathVariable String id,
                           @RequestParam String roomNumber, @RequestParam String type,
                           @RequestParam double pricePerNight, @RequestParam int capacity,
                           @RequestParam String description, @RequestParam String amenities,
                           @RequestParam String status,
                           @RequestParam(required = false) MultipartFile image,
                           HttpSession session, RedirectAttributes ra) {
        if (session.getAttribute("loggedAdmin") == null) return "redirect:/admin/login";

        Optional<Room> existing = roomService.getRoomById(id);
        if (!existing.isPresent()) return "redirect:/room/manage";

        Room room = existing.get();
        room.setRoomNumber(roomNumber);
        room.setType(type);
        room.setPricePerNight(pricePerNight);
        room.setCapacity(capacity);
        room.setDescription(description);
        room.setAmenities(Arrays.asList(amenities.split("\\|")));
        room.setStatus(Room.Status.valueOf(status));

        // Replace image only if a new one was uploaded
        String newImage = saveUploadedImage(image);
        if (newImage != null) {
            room.setStoredImageFile(newImage);
        }

        roomService.updateRoom(room);
        ra.addFlashAttribute("flash_success", "Room updated successfully!");
        return "redirect:/room/manage";
    }

    // --- Delete Room ---

    @PostMapping("/delete/{id}")
    public String deleteRoom(@PathVariable String id, HttpSession session, RedirectAttributes ra) {
        if (session.getAttribute("loggedAdmin") == null) return "redirect:/admin/login";
        roomService.deleteRoom(id);
        ra.addFlashAttribute("flash_success", "Room deleted.");
        return "redirect:/room/manage";
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    /**
     * Saves an uploaded image to the upload directory.
     * Returns the relative filename (e.g. "uploads/abc123.jpg") or null if no file.
     */
    private String saveUploadedImage(MultipartFile image) {
        if (image == null || image.isEmpty()) return null;
        try {
            // Ensure uploads directory exists
            Path dir = Paths.get(uploadPath);
            Files.createDirectories(dir);

            // Generate unique filename preserving extension
            String original = image.getOriginalFilename();
            String ext = (original != null && original.contains("."))
                    ? original.substring(original.lastIndexOf('.'))
                    : ".jpg";
            String filename = UUID.randomUUID().toString().replace("-", "") + ext;
            File dest = dir.resolve(filename).toFile();
            image.transferTo(dest);

            return "uploads/" + filename; // relative to /images/ URL path
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
