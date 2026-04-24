<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Booking Confirmation – Roomie</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        :root{--bg:#060a12;--surface:rgba(255,255,255,0.04);--gold:#c9a84c;--gold-light:#e4c470;--text:#e2e8f0;--text-muted:#8ba3c2;--border:rgba(201,168,76,0.12);--radius:20px;--nav-height:70px;--shadow:0 8px 32px rgba(0,0,0,0.5);--glass-bg:rgba(255,255,255,0.04);--glass-border:rgba(255,255,255,0.08);--glass-blur:blur(24px);}
        [data-theme="light"]{--bg:#f0f4f8;--surface:rgba(255,255,255,0.7);--text:#1e293b;--text-muted:#4b6080;--border:rgba(30,58,95,0.1);--shadow:0 8px 32px rgba(0,0,0,0.08);--glass-bg:rgba(255,255,255,0.5);--glass-border:rgba(30,58,95,0.1);--glass-blur:blur(20px);}
        body{font-family:'Plus Jakarta Sans',sans-serif;background:var(--bg);color:var(--text);padding-top:var(--nav-height);min-height:100vh;display:flex;flex-direction:column;overflow-x:hidden;transition:background .5s,color .5s;}
        .page{flex:1;display:flex;align-items:center;justify-content:center;padding:3rem 1.5rem;position:relative;}
        .page::before{content:'';position:absolute;inset:0;background:radial-gradient(ellipse at 50% 30%,rgba(201,168,76,.08) 0%,transparent 60%);pointer-events:none;}
        .confirm-card{background:var(--glass-bg);backdrop-filter:var(--glass-blur);border:1px solid var(--glass-border);border-radius:24px;padding:3rem;max-width:540px;width:100%;box-shadow:var(--shadow);position:relative;overflow:hidden;animation:fadeUp .7s ease both;}
        .confirm-card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg,transparent,var(--gold),transparent);}
        .confirm-header{text-align:center;margin-bottom:2rem;}
        .confirm-icon{font-size:3.5rem;display:block;margin-bottom:1rem;animation:pulse 2s infinite;}
        @keyframes pulse{0%,100%{transform:scale(1);}50%{transform:scale(1.1);}}
        .confirm-title{font-family:'Outfit',sans-serif;font-size:1.8rem;font-weight:700;color:var(--text);}
        .confirm-sub{color:var(--text-muted);font-size:.9rem;margin-top:.5rem;}
        .details-box{background:rgba(201,168,76,.05);border:1px solid rgba(201,168,76,.12);border-radius:16px;padding:1.5rem;margin:1.5rem 0;}
        .detail-row{display:flex;justify-content:space-between;padding:.6rem 0;border-bottom:1px solid rgba(201,168,76,.06);font-size:.88rem;}
        .detail-row:last-child{border-bottom:none;}
        .detail-label{color:var(--text-muted);}
        .detail-val{color:var(--text);font-weight:600;}
        .total-row{display:flex;justify-content:space-between;padding:.8rem 0;font-size:1.1rem;font-weight:700;color:var(--gold);border-top:1px solid var(--border);margin-top:.5rem;}
        .actions{display:flex;flex-direction:column;gap:.8rem;margin-top:1.5rem;}
        .btn-pay{padding:1rem;background:linear-gradient(135deg,var(--gold),var(--gold-light));color:#0a0e18;border:none;border-radius:25px;font-size:1rem;font-weight:700;cursor:pointer;transition:all .4s cubic-bezier(.23,1,.32,1);text-align:center;text-decoration:none;display:block;box-shadow:0 4px 25px rgba(201,168,76,.35);}
        .btn-pay:hover{transform:translateY(-3px) scale(1.02);box-shadow:0 8px 40px rgba(201,168,76,.5);}
        .btn-back{padding:.85rem;border:1.5px solid var(--glass-border);color:var(--text-muted);border-radius:25px;font-size:.9rem;text-align:center;text-decoration:none;display:block;transition:all .3s;backdrop-filter:blur(8px);}
        .btn-back:hover{border-color:var(--gold);color:var(--gold);}
        .booking-ref{text-align:center;font-size:.78rem;color:var(--text-muted);margin-top:1rem;}
        .booking-ref span{color:var(--gold);}
        @keyframes fadeUp{from{opacity:0;transform:translateY(35px)}to{opacity:1;transform:translateY(0)}}
    </style>
</head>
<body>
<jsp:include page="../navbar.jsp"/>
<div class="page">
    <div class="confirm-card">
        <div class="confirm-header">
            <span class="confirm-icon">🎉</span>
            <h1 class="confirm-title">Booking Confirmed!</h1>
            <p class="confirm-sub">Your reservation is pending payment. Complete it to confirm.</p>
        </div>
        <div class="details-box">
            <div class="detail-row"><span class="detail-label">Room</span><span class="detail-val">${room.displayType} Room ${room.roomNumber}</span></div>
            <div class="detail-row"><span class="detail-label">Check-In</span><span class="detail-val">${reservation.checkIn}</span></div>
            <div class="detail-row"><span class="detail-label">Check-Out</span><span class="detail-val">${reservation.checkOut}</span></div>
            <div class="detail-row"><span class="detail-label">Nights</span><span class="detail-val">${reservation.nights}</span></div>
            <div class="detail-row"><span class="detail-label">Rate/Night</span><span class="detail-val">LKR ${room.pricePerNight}</span></div>
            <div class="total-row"><span>Total Amount</span><span>LKR ${reservation.totalPrice}</span></div>
        </div>
        <div class="actions">
            <a href="/payment/checkout/${reservation.reservationId}" class="btn-pay">Proceed to Payment →</a>
            <a href="/reservation/my" class="btn-back">Pay Later (My Bookings)</a>
        </div>
        <div class="booking-ref">Booking ID: <span>${reservation.reservationId}</span></div>
    </div>
</div>
<script>const t=localStorage.getItem('roomie-theme')||'dark';document.documentElement.setAttribute('data-theme',t);</script>
</body>
</html>
