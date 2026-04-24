<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>My Bookings – Roomie</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        :root{--bg:#060a12;--bg2:#0a1020;--bg3:#0e1830;--surface:rgba(255,255,255,0.04);--gold:#c9a84c;--gold-light:#e4c470;--text:#e2e8f0;--text-muted:#8ba3c2;--text-faint:#4a6285;--border:rgba(201,168,76,0.12);--radius:20px;--nav-height:70px;--shadow:0 8px 32px rgba(0,0,0,0.5);--glow:0 0 60px rgba(201,168,76,0.12);--glass-bg:rgba(255,255,255,0.04);--glass-border:rgba(255,255,255,0.08);--glass-blur:blur(24px);}
        [data-theme="light"]{--bg:#f0f4f8;--bg2:#e8edf5;--bg3:#dde5f0;--surface:rgba(255,255,255,0.7);--text:#1e293b;--text-muted:#4b6080;--border:rgba(30,58,95,0.1);--shadow:0 8px 32px rgba(0,0,0,0.08);--glow:0 0 60px rgba(201,168,76,0.08);--glass-bg:rgba(255,255,255,0.5);--glass-border:rgba(30,58,95,0.1);--glass-blur:blur(20px);}
        body{font-family:'Plus Jakarta Sans',sans-serif;background:var(--bg);color:var(--text);padding-top:var(--nav-height);overflow-x:hidden;transition:background .5s,color .5s;}
        .hero-bar{position:relative;background:linear-gradient(135deg,var(--bg2),var(--bg3));border-bottom:1px solid var(--border);padding:3rem 1.5rem;overflow:hidden;}
        .hero-bar::before{content:'';position:absolute;inset:0;background:radial-gradient(ellipse at 50% 0%,rgba(201,168,76,.1) 0%,transparent 60%);pointer-events:none;}
        [data-theme="light"] .hero-bar{background:linear-gradient(135deg,#1e3a5f,#2e5fa3);}
        [data-theme="light"] .hero-bar h1,[data-theme="light"] .hero-bar p{color:#fff;}
        .hero-bar h1{font-family:'Outfit',sans-serif;font-size:2rem;font-weight:700;position:relative;animation:fadeUp .7s ease both;}
        .hero-bar p{color:var(--text-muted);margin-top:.4rem;font-size:.9rem;position:relative;animation:fadeUp .7s .1s ease both;}
        .container{max-width:1100px;margin:0 auto;padding:3rem 1.5rem;}
        .flash{padding:.85rem 1rem;border-radius:12px;margin-bottom:1.5rem;font-size:.86rem;border-left:4px solid;backdrop-filter:blur(12px);}
        .flash-success{background:rgba(22,163,74,.1);border-color:#16a34a;color:#4ade80;}
        .reservations-list{display:flex;flex-direction:column;gap:1.5rem;}
        .res-card{background:var(--glass-bg);backdrop-filter:var(--glass-blur);border:1px solid var(--glass-border);border-radius:var(--radius);overflow:hidden;display:grid;grid-template-columns:180px 1fr auto;align-items:center;transition:all .4s cubic-bezier(.23,1,.32,1);}
        @media(max-width:700px){.res-card{grid-template-columns:1fr;}}
        .res-card:hover{border-color:rgba(201,168,76,.35);box-shadow:0 10px 40px rgba(0,0,0,.3),var(--glow);transform:translateY(-4px);}
        .res-img{height:140px;object-fit:cover;width:180px;}
        @media(max-width:700px){.res-img{width:100%;height:160px;}}
        .res-body{padding:1.4rem;}
        .res-id{font-size:.74rem;color:var(--text-faint);letter-spacing:1px;margin-bottom:.2rem;}
        .res-room{font-family:'Outfit',sans-serif;font-size:1.1rem;color:var(--text);margin-bottom:.5rem;}
        .res-dates{font-size:.85rem;color:var(--text-muted);}
        .res-nights{font-size:.82rem;color:var(--text-muted);margin-top:.3rem;}
        .res-price{color:var(--gold);font-weight:700;font-size:1rem;margin-top:.4rem;}
        .res-actions{padding:1.5rem;display:flex;flex-direction:column;gap:.6rem;align-items:flex-end;}
        .badge{display:inline-block;padding:.25rem .9rem;border-radius:20px;font-size:.75rem;font-weight:600;margin-bottom:.5rem;}
        .badge-pending{background:rgba(245,158,11,.15);color:#fbbf24;}
        .badge-confirmed{background:rgba(22,163,74,.15);color:#4ade80;}
        .badge-cancelled{background:rgba(220,38,38,.15);color:#f87171;}
        .badge-checked_in{background:rgba(14,165,233,.15);color:#38bdf8;}
        .badge-checked_out{background:rgba(100,116,139,.15);color:#94a3b8;}
        .btn-pay-now{padding:.45rem 1.1rem;background:linear-gradient(135deg,var(--gold),var(--gold-light));color:#0a0e18;border-radius:20px;text-decoration:none;font-size:.82rem;font-weight:700;box-shadow:0 2px 10px rgba(201,168,76,.3);transition:all .3s;}
        .btn-pay-now:hover{transform:translateY(-2px);box-shadow:0 4px 20px rgba(201,168,76,.4);}
        .btn-cancel{padding:.4rem 1rem;border:1px solid rgba(220,38,38,.4);color:#f87171;border-radius:20px;font-size:.8rem;background:transparent;cursor:pointer;transition:all .2s;}
        .btn-cancel:hover{background:rgba(220,38,38,.1);}
        .no-data{text-align:center;padding:4rem;border:1px dashed var(--border);border-radius:var(--radius);color:var(--text-muted);background:var(--glass-bg);backdrop-filter:var(--glass-blur);}
        .no-data a{color:var(--gold);text-decoration:none;font-weight:600;}
        .reveal{opacity:0;transform:translateY(40px);transition:opacity .9s cubic-bezier(.23,1,.32,1),transform .9s cubic-bezier(.23,1,.32,1);}
        .reveal.visible{opacity:1;transform:translateY(0);}
        @keyframes fadeUp{from{opacity:0;transform:translateY(35px)}to{opacity:1;transform:translateY(0)}}
    </style>
</head>
<body>
<jsp:include page="../navbar.jsp"/>
<div class="hero-bar"><h1>My Bookings</h1><p>Track and manage all your reservations here.</p></div>
<div class="container">
    <c:if test="${not empty flash_success}"><div class="flash flash-success">${flash_success}</div></c:if>
    <c:choose>
        <c:when test="${empty reservations}">
            <div class="no-data"><p style="font-size:1.2rem;margin-bottom:1rem;">✨ No bookings yet!</p><a href="/room/list">Browse Rooms</a> to start your journey.</div>
        </c:when>
        <c:otherwise>
            <div class="reservations-list">
                <c:forEach var="r" items="${reservations}" varStatus="loop">
                    <div class="res-card reveal" style="transition-delay:${loop.index * 0.08}s;">
                        <c:forEach var="rm" items="${rooms}"><c:if test="${rm.roomId == r.roomId}"><img src="/images/${rm.imageFile}" class="res-img" alt="Room"></c:if></c:forEach>
                        <div class="res-body">
                            <div class="res-id">${r.reservationId}</div>
                            <c:forEach var="rm" items="${rooms}"><c:if test="${rm.roomId == r.roomId}"><div class="res-room">${rm.type} Room ${rm.roomNumber}</div></c:if></c:forEach>
                            <div class="res-dates">📅 ${r.checkIn} → ${r.checkOut}</div>
                            <div class="res-nights">🌙 ${r.nights} night(s)</div>
                            <div class="res-price">LKR ${r.totalPrice}</div>
                        </div>
                        <div class="res-actions">
                            <span class="badge badge-${r.status.name().toLowerCase()}">${r.status}</span>
                            <c:if test="${r.status.name() == 'PENDING'}"><a href="/payment/checkout/${r.reservationId}" class="btn-pay-now">Pay Now</a></c:if>
                            <c:if test="${r.status.name() != 'CANCELLED' and r.status.name() != 'CHECKED_OUT'}">
                                <form action="/reservation/cancel/${r.reservationId}" method="post" onsubmit="return confirm('Cancel this reservation?')"><button type="submit" class="btn-cancel">Cancel</button></form>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<script>
const t=localStorage.getItem('roomie-theme')||'dark';document.documentElement.setAttribute('data-theme',t);
var ro=new IntersectionObserver(function(e){e.forEach(function(x){if(x.isIntersecting)x.target.classList.add('visible');});},{threshold:.1});
document.querySelectorAll('.reveal').forEach(function(el){ro.observe(el);});
</script>
</body>
</html>
