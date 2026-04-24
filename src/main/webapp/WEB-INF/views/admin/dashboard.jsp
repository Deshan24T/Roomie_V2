<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Admin Dashboard – Roomie</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        :root{--bg:#060a12;--bg2:#0a1020;--bg3:#0e1830;--surface:rgba(255,255,255,0.04);--surface2:rgba(255,255,255,0.07);--gold:#c9a84c;--gold-light:#e4c470;--text:#e2e8f0;--text-muted:#8ba3c2;--text-faint:#4a6285;--border:rgba(201,168,76,0.12);--radius:20px;--nav-height:70px;--shadow:0 8px 32px rgba(0,0,0,0.5);--glow:0 0 60px rgba(201,168,76,0.12);--glass-bg:rgba(255,255,255,0.04);--glass-border:rgba(255,255,255,0.08);--glass-blur:blur(24px);}
        [data-theme="light"]{--bg:#f0f4f8;--bg2:#e8edf5;--bg3:#dde5f0;--surface:rgba(255,255,255,0.7);--surface2:rgba(255,255,255,0.85);--text:#1e293b;--text-muted:#4b6080;--text-faint:#8ea3bf;--border:rgba(30,58,95,0.1);--shadow:0 8px 32px rgba(0,0,0,0.08);--glow:0 0 60px rgba(201,168,76,0.08);--glass-bg:rgba(255,255,255,0.5);--glass-border:rgba(30,58,95,0.1);--glass-blur:blur(20px);}
        body{font-family:'Plus Jakarta Sans',sans-serif;background:var(--bg);color:var(--text);padding-top:var(--nav-height);overflow-x:hidden;transition:background .5s,color .5s;}
        .main{max-width:1300px;margin:0 auto;padding:2.5rem 2rem;}
        .page-header{margin-bottom:2.5rem;animation:fadeUp .7s ease both;}
        .page-header h1{font-family:'Outfit',sans-serif;font-size:2rem;font-weight:700;}
        .page-header p{color:var(--text-muted);font-size:.9rem;margin-top:.4rem;}
        .stats-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:1.5rem;margin-bottom:2.5rem;}
        .stat-card{background:var(--glass-bg);backdrop-filter:var(--glass-blur);border:1px solid var(--glass-border);border-radius:var(--radius);padding:1.8rem 1.5rem;transition:all .4s cubic-bezier(.23,1,.32,1);position:relative;overflow:hidden;}
        .stat-card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg,transparent,var(--gold),transparent);opacity:0;transition:opacity .4s;}
        .stat-card:hover{transform:translateY(-6px);border-color:rgba(201,168,76,.35);box-shadow:0 10px 30px rgba(0,0,0,.3),var(--glow);}
        .stat-card:hover::before{opacity:1;}
        .stat-icon{font-size:2rem;margin-bottom:.8rem;display:block;}
        .stat-val{font-family:'Outfit',sans-serif;font-size:2.2rem;font-weight:700;color:var(--gold);}
        .stat-label{font-size:.76rem;color:var(--text-muted);text-transform:uppercase;letter-spacing:1px;margin-top:.2rem;}
        .stat-card.revenue .stat-val{font-size:1.5rem;}
        .card{background:var(--glass-bg);backdrop-filter:var(--glass-blur);border:1px solid var(--glass-border);border-radius:var(--radius);padding:1.8rem;margin-bottom:2rem;box-shadow:var(--shadow);position:relative;overflow:hidden;animation:fadeUp .8s .2s ease both;}
        .card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg,transparent,var(--gold),transparent);}
        .card-title{font-family:'Outfit',sans-serif;font-size:1.1rem;font-weight:600;margin-bottom:1.5rem;}
        .table-wrap{overflow-x:auto;}
        table{width:100%;border-collapse:collapse;font-size:.86rem;}
        th{text-align:left;padding:.7rem 1rem;color:var(--gold);font-size:.74rem;letter-spacing:1px;text-transform:uppercase;font-weight:600;border-bottom:1px solid var(--border);}
        td{padding:.85rem 1rem;border-bottom:1px solid rgba(201,168,76,.06);color:var(--text-muted);}
        tr:last-child td{border-bottom:none;}
        tr:hover td{background:rgba(201,168,76,.03);}
        .badge{display:inline-block;padding:.2rem .7rem;border-radius:20px;font-size:.72rem;font-weight:600;}
        .badge-pending{background:rgba(245,158,11,.15);color:#fbbf24;}
        .badge-confirmed{background:rgba(22,163,74,.15);color:#4ade80;}
        .badge-cancelled{background:rgba(220,38,38,.15);color:#f87171;}
        .badge-checked_in{background:rgba(14,165,233,.15);color:#38bdf8;}
        .badge-checked_out{background:rgba(100,116,139,.15);color:#94a3b8;}
        .no-data{text-align:center;padding:2rem;color:var(--text-faint);}
        .reveal{opacity:0;transform:translateY(40px);transition:opacity .9s cubic-bezier(.23,1,.32,1),transform .9s cubic-bezier(.23,1,.32,1);}
        .reveal.visible{opacity:1;transform:translateY(0);}
        @keyframes fadeUp{from{opacity:0;transform:translateY(35px)}to{opacity:1;transform:translateY(0)}}
    </style>
</head>
<body>
<jsp:include page="../navbar.jsp"/>
<main class="main">
    <div class="page-header"><h1>Dashboard</h1><p>Welcome back, ${sessionScope.loggedAdmin.firstName}! Here's what's happening at Roomie.</p></div>
    <div class="stats-grid">
        <div class="stat-card reveal"><span class="stat-icon">🏨</span><div class="stat-val">${totalRooms}</div><div class="stat-label">Total Rooms</div></div>
        <div class="stat-card reveal"><span class="stat-icon">✅</span><div class="stat-val">${availableRooms}</div><div class="stat-label">Available</div></div>
        <div class="stat-card reveal"><span class="stat-icon">👥</span><div class="stat-val">${totalCustomers}</div><div class="stat-label">Customers</div></div>
        <div class="stat-card reveal"><span class="stat-icon">📋</span><div class="stat-val">${totalReservations}</div><div class="stat-label">Reservations</div></div>
        <div class="stat-card revenue reveal"><span class="stat-icon">💰</span><div class="stat-val">LKR ${totalRevenue}</div><div class="stat-label">Total Revenue</div></div>
        <div class="stat-card reveal"><span class="stat-icon">⭐</span><div class="stat-val">${totalReviews}</div><div class="stat-label">Reviews</div></div>
    </div>
    <div class="card">
        <div class="card-title">Recent Reservations</div>
        <c:choose>
            <c:when test="${empty recentReservations}"><div class="no-data">No reservations yet.</div></c:when>
            <c:otherwise>
                <div class="table-wrap"><table><thead><tr><th>ID</th><th>Customer</th><th>Room</th><th>Check-In</th><th>Check-Out</th><th>Total</th><th>Status</th></tr></thead><tbody>
                <c:forEach var="r" items="${recentReservations}"><tr><td>${r.reservationId}</td><td>${r.customerId}</td><td>${r.roomId}</td><td>${r.checkIn}</td><td>${r.checkOut}</td><td>LKR ${r.totalPrice}</td><td><span class="badge badge-${r.status.name().toLowerCase()}">${r.status}</span></td></tr></c:forEach>
                </tbody></table></div>
            </c:otherwise>
        </c:choose>
    </div>
</main>
<script>
(function(){var t=localStorage.getItem('roomie-theme')||'dark';document.documentElement.setAttribute('data-theme',t);})();
var ro=new IntersectionObserver(function(e){e.forEach(function(x){if(x.isIntersecting)x.target.classList.add('visible');});},{threshold:.1});
document.querySelectorAll('.reveal').forEach(function(el,i){el.style.transitionDelay=(i*0.08)+'s';ro.observe(el);});
</script>
</body>
</html>
