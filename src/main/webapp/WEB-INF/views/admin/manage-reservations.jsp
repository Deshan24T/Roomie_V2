<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Manage Reservations – Roomie Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        :root{--bg:#060a12;--bg2:#0a1020;--surface:rgba(255,255,255,0.04);--surface2:rgba(255,255,255,0.07);--gold:#c9a84c;--gold-light:#e4c470;--text:#e2e8f0;--text-muted:#8ba3c2;--text-faint:#4a6285;--border:rgba(201,168,76,0.12);--radius:20px;--nav-height:70px;--shadow:0 8px 32px rgba(0,0,0,0.5);--glass-bg:rgba(255,255,255,0.04);--glass-border:rgba(255,255,255,0.08);--glass-blur:blur(24px);}
        [data-theme="light"]{--bg:#f0f4f8;--bg2:#e8edf5;--surface:rgba(255,255,255,0.7);--surface2:rgba(255,255,255,0.85);--text:#1e293b;--text-muted:#4b6080;--text-faint:#8ea3bf;--border:rgba(30,58,95,0.1);--shadow:0 8px 32px rgba(0,0,0,0.08);--glass-bg:rgba(255,255,255,0.5);--glass-border:rgba(30,58,95,0.1);--glass-blur:blur(20px);}
        body{font-family:'Plus Jakarta Sans',sans-serif;background:var(--bg);color:var(--text);padding-top:var(--nav-height);overflow-x:hidden;transition:background .5s,color .5s;}
        .container{max-width:1300px;margin:0 auto;padding:2.5rem 1.5rem;}
        .back-link{color:var(--gold);text-decoration:none;font-size:.85rem;display:inline-flex;align-items:center;gap:.4rem;margin-bottom:1.5rem;animation:fadeUp .6s ease both;}
        .page-title{font-family:'Outfit',sans-serif;font-size:1.8rem;margin-bottom:2rem;animation:fadeUp .7s ease both;}
        .flash{padding:.85rem 1rem;border-radius:12px;margin-bottom:1.5rem;font-size:.86rem;border-left:4px solid;backdrop-filter:blur(12px);}
        .flash-success{background:rgba(22,163,74,.1);border-color:#16a34a;color:#4ade80;}
        .card{background:var(--glass-bg);backdrop-filter:var(--glass-blur);border:1px solid var(--glass-border);border-radius:var(--radius);overflow:hidden;box-shadow:var(--shadow);position:relative;animation:fadeUp .8s .1s ease both;}
        .card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg,transparent,var(--gold),transparent);}
        .table-wrap{overflow-x:auto;}
        table{width:100%;border-collapse:collapse;font-size:.84rem;}
        th{text-align:left;padding:.8rem 1rem;background:var(--surface2);color:var(--gold);font-size:.72rem;letter-spacing:1px;text-transform:uppercase;font-weight:600;}
        td{padding:.85rem 1rem;border-bottom:1px solid rgba(201,168,76,.06);color:var(--text-muted);}
        tr:last-child td{border-bottom:none;}
        tr:hover td{background:rgba(201,168,76,.03);}
        .badge{display:inline-block;padding:.2rem .7rem;border-radius:20px;font-size:.72rem;font-weight:600;}
        .badge-pending{background:rgba(245,158,11,.15);color:#fbbf24;}
        .badge-confirmed{background:rgba(22,163,74,.15);color:#4ade80;}
        .badge-cancelled{background:rgba(220,38,38,.15);color:#f87171;}
        .badge-checked_in{background:rgba(14,165,233,.15);color:#38bdf8;}
        .badge-checked_out{background:rgba(100,116,139,.15);color:#94a3b8;}
        select{background:var(--surface2);color:var(--text);border:1px solid var(--border);border-radius:8px;padding:.3rem .6rem;font-size:.78rem;cursor:pointer;transition:border-color .3s;}
        select:focus{outline:none;border-color:var(--gold);}
        .btn-update{padding:.3rem .8rem;background:linear-gradient(135deg,var(--gold),var(--gold-light));color:#0a0e18;border:none;border-radius:20px;font-size:.74rem;font-weight:600;cursor:pointer;transition:all .3s;box-shadow:0 2px 8px rgba(201,168,76,.2);}
        .btn-update:hover{transform:translateY(-1px);box-shadow:0 4px 15px rgba(201,168,76,.3);}
        .no-data{text-align:center;padding:3rem;color:var(--text-faint);}
        @keyframes fadeUp{from{opacity:0;transform:translateY(35px)}to{opacity:1;transform:translateY(0)}}
    </style>
</head>
<body>
<jsp:include page="../navbar.jsp"/>
<div class="container">
    <a href="/admin/dashboard" class="back-link">← Dashboard</a>
    <h1 class="page-title">All Reservations</h1>
    <c:if test="${not empty flash_success}"><div class="flash flash-success">${flash_success}</div></c:if>
    <div class="card">
        <c:choose>
            <c:when test="${empty reservations}"><div class="no-data">No reservations yet.</div></c:when>
            <c:otherwise>
                <div class="table-wrap"><table><thead><tr><th>ID</th><th>Customer</th><th>Room</th><th>Check-In</th><th>Check-Out</th><th>Nights</th><th>Total</th><th>Status</th><th>Update</th></tr></thead><tbody>
                <c:forEach var="r" items="${reservations}"><tr>
                    <td>${r.reservationId}</td><td>${r.customerId}</td><td>${r.roomId}</td><td>${r.checkIn}</td><td>${r.checkOut}</td><td>${r.nights}</td><td>LKR ${r.totalPrice}</td>
                    <td><span class="badge badge-${r.status.name().toLowerCase()}">${r.status}</span></td>
                    <td><form action="/admin/reservations/status" method="post" style="display:flex;gap:.4rem;align-items:center;"><input type="hidden" name="reservationId" value="${r.reservationId}"><select name="status"><option value="PENDING">PENDING</option><option value="CONFIRMED">CONFIRMED</option><option value="CHECKED_IN">CHECKED_IN</option><option value="CHECKED_OUT">CHECKED_OUT</option><option value="CANCELLED">CANCELLED</option></select><button type="submit" class="btn-update">Set</button></form></td>
                </tr></c:forEach>
                </tbody></table></div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<script>(function(){var t=localStorage.getItem('roomie-theme')||'dark';document.documentElement.setAttribute('data-theme',t);})();</script>
</body>
</html>
