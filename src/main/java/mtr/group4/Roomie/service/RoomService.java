package mtr.group4.Roomie.service;

import mtr.group4.Roomie.model.Room;
import mtr.group4.Roomie.repository.RoomRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class RoomService {

    private final RoomRepository roomRepo;

    public RoomService(RoomRepository roomRepo) {
        this.roomRepo = roomRepo;
    }

    public ArrayList<Room> getAllRooms() { return roomRepo.findAll(); }

    public ArrayList<Room> getAvailableRooms() { return roomRepo.findAvailable(); }

    public Optional<Room> getRoomById(String id) { return roomRepo.findById(id); }

    public void addRoom(Room room) {
        room.setRoomId(roomRepo.generateId());
        roomRepo.save(room);
    }

    public void updateRoom(Room room) { roomRepo.update(room); }

    public void deleteRoom(String id) { roomRepo.delete(id); }

    public ArrayList<Room> getRoomsByType(String type) {
        ArrayList<Room> filtered = new ArrayList<>();
        for (Room r : roomRepo.findAll())
            if (r.getType().equalsIgnoreCase(type)) filtered.add(r);
        return filtered;
    }

    public int countRooms() { return roomRepo.findAll().size(); }
    public int countAvailableRooms() { return roomRepo.findAvailable().size(); }
}
