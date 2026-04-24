package mtr.group4.Roomie.model;

public class Payment extends BaseEntity {

    public enum Status { PENDING, COMPLETED, FAILED, REFUNDED }

    private String paymentId;
    private String reservationId;
    private double amount;
    private String method;
    private Status status;
    private String paidDate;

    public Payment() { super(); }

    public Payment(String paymentId, String reservationId, double amount,
                   String method, String status, String paidDate, String createdDate) {
        super(createdDate);
        this.paymentId     = paymentId;
        this.reservationId = reservationId;
        this.amount        = amount;
        this.method        = method;
        this.status        = Status.valueOf(status);
        this.paidDate      = paidDate;
    }

    @Override public String getEntityType() { return "PAYMENT"; }

    public String toCsv() {
        return String.join(",", paymentId, reservationId, String.valueOf(amount),
                method, status.name(), paidDate, getCreatedDate());
    }

    public static Payment fromCsv(String line) {
        String[] p = line.split(",", 7);
        if (p.length < 7) return null;
        return new Payment(p[0], p[1], Double.parseDouble(p[2]), p[3], p[4], p[5], p[6]);
    }

    public String getPaymentId()                    { return paymentId; }
    public void   setPaymentId(String paymentId)    { this.paymentId = paymentId; }
    public String getReservationId()                        { return reservationId; }
    public void   setReservationId(String reservationId)    { this.reservationId = reservationId; }
    public double getAmount()               { return amount; }
    public void   setAmount(double amount)  { this.amount = amount; }
    public String getMethod()               { return method; }
    public void   setMethod(String method)  { this.method = method; }
    public Status getStatus()               { return status; }
    public void   setStatus(Status s)       { this.status = s; }
    public String getPaidDate()                 { return paidDate; }
    public void   setPaidDate(String paidDate)  { this.paidDate = paidDate; }
}
