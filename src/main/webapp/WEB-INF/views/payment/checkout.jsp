<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Checkout – Roomie</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        :root{--bg:#060a12;--bg2:#0a1020;--surface:rgba(255,255,255,0.04);--gold:#c9a84c;--gold-light:#e4c470;--text:#e2e8f0;--text-muted:#8ba3c2;--border:rgba(201,168,76,0.12);--radius:20px;--nav-height:70px;--shadow:0 8px 32px rgba(0,0,0,0.5);--glow:0 0 60px rgba(201,168,76,0.12);--glass-bg:rgba(255,255,255,0.04);--glass-border:rgba(255,255,255,0.08);--glass-blur:blur(24px);}
        [data-theme="light"]{--bg:#f0f4f8;--bg2:#e8edf5;--surface:rgba(255,255,255,0.7);--text:#1e293b;--text-muted:#4b6080;--border:rgba(30,58,95,0.1);--shadow:0 8px 32px rgba(0,0,0,0.08);--glass-bg:rgba(255,255,255,0.5);--glass-border:rgba(30,58,95,0.1);--glass-blur:blur(20px);}
        body{font-family:'Plus Jakarta Sans',sans-serif;background:var(--bg);color:var(--text);padding-top:var(--nav-height);overflow-x:hidden;transition:background .5s,color .5s;}
        .container{max-width:900px;margin:0 auto;padding:3rem 1.5rem;}
        .back-link{color:var(--gold);text-decoration:none;font-size:.87rem;display:inline-flex;align-items:center;gap:.4rem;margin-bottom:2rem;animation:fadeUp .6s ease both;}
        .page-title{font-family:'Outfit',sans-serif;font-size:2rem;font-weight:700;margin-bottom:2rem;animation:fadeUp .7s ease both;}
        .checkout-grid{display:grid;grid-template-columns:1.2fr 1fr;gap:2.5rem;align-items:start;}
        @media(max-width:700px){.checkout-grid{grid-template-columns:1fr;}}
        .summary-card,.payment-card{background:var(--glass-bg);backdrop-filter:var(--glass-blur);border:1px solid var(--glass-border);border-radius:var(--radius);padding:2rem;box-shadow:var(--shadow);position:relative;overflow:hidden;}
        .summary-card{animation:fadeUp .7s .1s ease both;}
        .payment-card{animation:fadeUp .7s .2s ease both;}
        .summary-card::before,.payment-card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg,transparent,var(--gold),transparent);}
        .card-title{font-family:'Outfit',sans-serif;font-size:1.1rem;font-weight:600;color:var(--gold);margin-bottom:1.5rem;padding-bottom:.8rem;border-bottom:1px solid var(--border);}
        .sum-row{display:flex;justify-content:space-between;padding:.6rem 0;font-size:.88rem;border-bottom:1px solid rgba(201,168,76,.06);}
        .sum-row:last-child{border-bottom:none;}
        .sum-label{color:var(--text-muted);}
        .sum-val{color:var(--text);font-weight:600;}
        .sum-total{display:flex;justify-content:space-between;padding:.9rem 0;font-size:1.1rem;font-weight:700;color:var(--gold);border-top:2px solid var(--border);margin-top:.5rem;}
        .payment-methods{display:flex;flex-direction:column;gap:.8rem;margin-bottom:1.5rem;}
        .method-option{display:flex;align-items:center;gap:1rem;padding:1rem;border:1.5px solid var(--glass-border);border-radius:14px;cursor:pointer;transition:all .3s cubic-bezier(.23,1,.32,1);backdrop-filter:blur(8px);}
        .method-option:has(input:checked){border-color:var(--gold);background:rgba(201,168,76,.06);box-shadow:0 0 20px rgba(201,168,76,.08);}
        .method-option input{accent-color:var(--gold);}
        .method-icon{font-size:1.5rem;}
        .method-name{font-size:.9rem;font-weight:600;color:var(--text);}
        .method-sub{font-size:.75rem;color:var(--text-muted);}
        .btn-pay{width:100%;padding:1rem;background:linear-gradient(135deg,var(--gold),var(--gold-light));color:#0a0e18;border:none;border-radius:25px;font-size:1rem;font-weight:700;cursor:pointer;transition:all .4s cubic-bezier(.23,1,.32,1);box-shadow:0 4px 25px rgba(201,168,76,.35);}
        .btn-pay:hover{transform:translateY(-3px) scale(1.02);box-shadow:0 8px 40px rgba(201,168,76,.5);}
        .secure-note{text-align:center;font-size:.78rem;color:var(--text-muted);margin-top:1rem;}
        .res-img{width:100%;height:160px;object-fit:cover;border-radius:14px;margin-bottom:1rem;}
        @keyframes fadeUp{from{opacity:0;transform:translateY(35px)}to{opacity:1;transform:translateY(0)}}
    </style>
</head>
<body>
<jsp:include page="../navbar.jsp"/>
<div class="container">
    <a href="/reservation/my" class="back-link">← My Bookings</a>
    <h1 class="page-title">Secure Checkout</h1>
    <div class="checkout-grid">
        <div class="summary-card">
            <div class="card-title">Order Summary</div>
            <img src="/images/${room.imageFile}" class="res-img" alt="Room">
            <div class="sum-row"><span class="sum-label">Room</span><span class="sum-val">${room.displayType} – Room ${room.roomNumber}</span></div>
            <div class="sum-row"><span class="sum-label">Check-In</span><span class="sum-val">${reservation.checkIn}</span></div>
            <div class="sum-row"><span class="sum-label">Check-Out</span><span class="sum-val">${reservation.checkOut}</span></div>
            <div class="sum-row"><span class="sum-label">Nights</span><span class="sum-val">${reservation.nights}</span></div>
            <div class="sum-row"><span class="sum-label">Rate/Night</span><span class="sum-val">LKR ${room.pricePerNight}</span></div>
            <div class="sum-total"><span>Total</span><span>LKR ${reservation.totalPrice}</span></div>
        </div>
        <div class="payment-card">
            <div class="card-title">Choose Payment Method</div>
            <form action="/payment/process" method="post">
                <input type="hidden" name="reservationId" value="${reservation.reservationId}">
                <div class="payment-methods">
                    <label class="method-option"><input type="radio" name="method" value="CREDIT_CARD" checked><span class="method-icon">💳</span><div><div class="method-name">Credit / Debit Card</div><div class="method-sub">Visa, Mastercard, Amex</div></div></label>
                    <label class="method-option"><input type="radio" name="method" value="BANK_TRANSFER"><span class="method-icon">🏦</span><div><div class="method-name">Bank Transfer</div><div class="method-sub">Online bank payment</div></div></label>
                    <label class="method-option"><input type="radio" name="method" value="CASH"><span class="method-icon">💵</span><div><div class="method-name">Cash on Arrival</div><div class="method-sub">Pay at front desk</div></div></label>
                </div>
                <button type="submit" class="btn-pay">Complete Payment – LKR ${reservation.totalPrice}</button>
                <div class="secure-note">🔒 Secure & encrypted payment</div>
            </form>
        </div>
    </div>
</div>
<script>const t=localStorage.getItem('roomie-theme')||'dark';document.documentElement.setAttribute('data-theme',t);</script>
</body>
</html>
