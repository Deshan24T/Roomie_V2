package mtr.group4.Roomie.controller;

import mtr.group4.Roomie.service.RoomService;
import mtr.group4.Roomie.service.ReviewService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    private final RoomService roomService;
    private final ReviewService reviewService;

    public HomeController(RoomService roomService, ReviewService reviewService) {
        this.roomService   = roomService;
        this.reviewService = reviewService;
    }

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("featuredRooms", roomService.getAvailableRooms());
        model.addAttribute("totalRooms",    roomService.countRooms());
        model.addAttribute("avgRating",     reviewService.getAverageRating());
        model.addAttribute("totalReviews",  reviewService.countReviews());
        model.addAttribute("allReviews",    reviewService.getAllReviews());
        return "home";
    }
}