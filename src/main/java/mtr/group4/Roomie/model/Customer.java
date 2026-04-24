package mtr.group4.Roomie.model;

public class Customer extends Person {

    private String phone;
    private String address;
    private String registeredDate;

    public Customer() {}

    public Customer(String id, String firstName, String lastName,
                    String email, String password,
                    String phone, String address, String registeredDate) {
        super(id, firstName, lastName, email, password);
        this.phone          = phone;
        this.address        = address;
        this.registeredDate = registeredDate;
    }

    @Override public String getRole() { return "CUSTOMER"; }

    public String toCsv() {
        return String.join(",", getId(), getFirstName(), getLastName(),
                getEmail(), getPassword(), phone, address, registeredDate);
    }

    public static Customer fromCsv(String line) {
        String[] p = line.split(",", 8);
        if (p.length < 8) return null;
        return new Customer(p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]);
    }

    public String getPhone()                { return phone; }
    public void   setPhone(String phone)    { this.phone = phone; }
    public String getAddress()                  { return address; }
    public void   setAddress(String address)    { this.address = address; }
    public String getRegisteredDate()                       { return registeredDate; }
    public void   setRegisteredDate(String registeredDate)  { this.registeredDate = registeredDate; }
}
