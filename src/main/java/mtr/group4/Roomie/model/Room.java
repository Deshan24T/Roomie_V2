package mtr.group4.Roomie.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Room extends BaseEntity {

    public enum Status { AVAILABLE, OCCUPIED, MAINTENANCE }

    private String roomId;
    private String roomNumber;
    private String type;
    private double pricePerNight;
    private int    capacity;
    private String description;
    private List<String> amenities;
    private Status status;
    private String imageFile; // stored filename (e.g. "uploads/my-room.jpg"), or null

    // Image resolver: prefer explicitly uploaded image, then fall back to type/view heuristic
    public String getImageFile() {
        if (imageFile != null && !imageFile.isBlank()) return imageFile;
        if (description != null) {
            String d = description.toLowerCase();
            if (type != null && type.equalsIgnoreCase("Suite"))        return "room-suite-panoramic.png";
            if (d.contains("ocean"))                                    return "room-deluxe-ocean.png";
            if (d.contains("garden") && type != null && type.equalsIgnoreCase("Deluxe")) return "room-deluxe-garden.png";
            if (d.contains("pool"))                                     return "room-standard-pool.png";
        }
        return "room-standard-garden.png";
    }

    public Room() { super(); }

    public Room(String roomId, String roomNumber, String type,
                double pricePerNight, int capacity, String description,
                List<String> amenities, String status, String createdDate) {
        this(roomId, roomNumber, type, pricePerNight, capacity, description, amenities, status, createdDate, null);
    }

    public Room(String roomId, String roomNumber, String type,
                double pricePerNight, int capacity, String description,
                List<String> amenities, String status, String createdDate, String imageFile) {
        super(createdDate);
        this.roomId        = roomId;
        this.roomNumber    = roomNumber;
        this.type          = type;
        this.pricePerNight = pricePerNight;
        this.capacity      = capacity;
        this.description   = description;
        this.amenities     = amenities != null ? amenities : new ArrayList<>();
        this.status        = Status.valueOf(status);
        this.imageFile     = imageFile;
    }

    @Override public String getEntityType() { return "ROOM"; }

    // CSV: roomId,roomNumber,type,price,capacity,description,amenities,status,imageFile
    public String toCsv() {
        String amen = String.join("|", amenities);
        String img  = (imageFile != null) ? imageFile : "";
        return String.join(",", roomId, roomNumber, type,
                String.valueOf(pricePerNight), String.valueOf(capacity),
                description, amen, status.name(), img);
    }

    public static Room fromCsv(String line) {
        String[] p = line.split(",", 9);
        if (p.length < 8) return null;
        List<String> amen = Arrays.asList(p[6].split("\\|"));
        String img = (p.length >= 9) ? p[8].trim() : "";
        return new Room(p[0], p[1], p[2], Double.parseDouble(p[3]),
                Integer.parseInt(p[4]), p[5], amen, p[7], "", img.isEmpty() ? null : img);
    }

    public String getAmenitiesDisplay() {
        return amenities != null ? String.join(", ", amenities) : "";
    }

    public String getAmenitiesPipe() {
        return amenities != null ? String.join("|", amenities) : "";
    }

    public String getRoomId()                           { return roomId; }
    public void   setRoomId(String id)                  { this.roomId = id; }
    public String getRoomNumber()                       { return roomNumber; }
    public void   setRoomNumber(String roomNumber)      { this.roomNumber = roomNumber; }
    public String getType()                             { return type; }
    /** Maps internal type to Antigravity-themed display name */
    public String getDisplayType() {
        if (type == null) return "";
        switch (type) {
            case "Standard": return "Coastal";
            case "Deluxe":   return "Hill Country";
            case "Suite":    return "Jungle";
            default:         return type;
        }
    }
    public void   setType(String type)                  { this.type = type; }
    public double getPricePerNight()                    { return pricePerNight; }
    public void   setPricePerNight(double pricePerNight){ this.pricePerNight = pricePerNight; }
    public int    getCapacity()                         { return capacity; }
    public void   setCapacity(int capacity)             { this.capacity = capacity; }
    public String getDescription()                      { return description; }
    public void   setDescription(String description)    { this.description = description; }
    public List<String> getAmenities()                  { return amenities; }
    public void         setAmenities(List<String> a)    { this.amenities = a; }
    public Status getStatus()                           { return status; }
    public void   setStatus(Status status)              { this.status = status; }
    public boolean isAvailable()                        { return Status.AVAILABLE.equals(status); }
    public String getStoredImageFile()                  { return imageFile; }
    public void   setStoredImageFile(String imageFile)  { this.imageFile = imageFile; }
}
