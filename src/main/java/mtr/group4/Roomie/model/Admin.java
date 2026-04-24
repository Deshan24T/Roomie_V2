package mtr.group4.Roomie.model;

public class Admin extends Person {

    private int adminLevel;

    public Admin() {}

    public Admin(String id, String firstName, String lastName,
                 String email, String password, int adminLevel) {
        super(id, firstName, lastName, email, password);
        this.adminLevel = adminLevel;
    }

    @Override public String getRole() { return "ADMIN"; }

    public String toCsv() {
        return String.join(",", getId(), getFirstName(), getLastName(),
                getEmail(), getPassword(), String.valueOf(adminLevel));
    }

    public static Admin fromCsv(String line) {
        String[] p = line.split(",", 6);
        if (p.length < 6) return null;
        return new Admin(p[0], p[1], p[2], p[3], p[4], Integer.parseInt(p[5].trim()));
    }

    public int  getAdminLevel()               { return adminLevel; }
    public void setAdminLevel(int adminLevel)  { this.adminLevel = adminLevel; }
}
