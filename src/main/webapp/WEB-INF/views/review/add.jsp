<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Write a Review – Roomie</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        :root{--bg:#060a12;--surface:rgba(255,255,255,0.04);--gold:#c9a84c;--gold-light:#e4c470;--text:#e2e8f0;--text-muted:#8ba3c2;--border:rgba(201,168,76,0.12);--radius:20px;--nav-height:70px;--shadow:0 8px 32px rgba(0,0,0,0.5);--glass-bg:rgba(255,255,255,0.04);--glass-border:rgba(255,255,255,0.08);--glass-blur:blur(24px);}
        [data-theme="light"]{--bg:#f0f4f8;--surface:rgba(255,255,255,0.7);--text:#1e293b;--text-muted:#4b6080;--border:rgba(30,58,95,0.1);--shadow:0 8px 32px rgba(0,0,0,0.08);--glass-bg:rgba(255,255,255,0.5);--glass-border:rgba(30,58,95,0.1);--glass-blur:blur(20px);}
        body{font-family:'Plus Jakarta Sans',sans-serif;background:var(--bg);color:var(--text);padding-top:var(--nav-height);min-height:100vh;display:flex;flex-direction:column;overflow-x:hidden;transition:background .5s,color .5s;}
        .page{flex:1;display:flex;align-items:center;justify-content:center;padding:3rem 1.5rem;position:relative;}
        .page::before{content:'';position:absolute;inset:0;background:radial-gradient(ellipse at 50% 0%,rgba(201,168,76,.08) 0%,transparent 60%);pointer-events:none;}
        .review-card{background:var(--glass-bg);backdrop-filter:var(--glass-blur);border:1px solid var(--glass-border);border-radius:24px;padding:3rem;width:100%;max-width:520px;box-shadow:var(--shadow);position:relative;overflow:hidden;animation:fadeUp .7s ease both;}
        .review-card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg,transparent,var(--gold),transparent);}
        .card-logo{text-align:center;margin-bottom:2rem;}
        .card-icon{font-size:2rem;display:block;margin-bottom:.5rem;}
        .card-title{font-family:'Outfit',sans-serif;font-size:1.8rem;color:var(--text);}
        .card-sub{color:var(--text-muted);font-size:.85rem;margin-top:.3rem;}
        .form-group{margin-bottom:1.3rem;}
        label{display:block;font-size:.8rem;color:var(--text-muted);margin-bottom:.5rem;font-weight:500;}
        select,textarea{width:100%;padding:.8rem 1rem;border-radius:12px;border:1.5px solid var(--border);background:rgba(8,14,26,.5);color:var(--text);font-size:.92rem;transition:border-color .3s,box-shadow .3s;font-family:'Plus Jakarta Sans',sans-serif;}
        [data-theme="light"] select,[data-theme="light"] textarea{background:#f0f4f8;}
        select:focus,textarea:focus{outline:none;border-color:var(--gold);box-shadow:0 0 0 3px rgba(201,168,76,.12);}
        textarea{resize:vertical;min-height:120px;}
        .star-group{display:flex;flex-direction:row-reverse;justify-content:flex-end;gap:.3rem;}
        .star-group input{display:none;}
        .star-group label{font-size:2.2rem;color:var(--text-muted);cursor:pointer;transition:color .15s,transform .2s;padding:0;}
        .star-group input:checked ~ label,.star-group label:hover,.star-group label:hover ~ label{color:var(--gold);transform:scale(1.1);}
        .star-selected-label{font-size:.82rem;color:var(--gold);margin-top:.4rem;}
        .btn-submit{width:100%;padding:.9rem;background:linear-gradient(135deg,var(--gold),var(--gold-light));color:#0a0e18;border:none;border-radius:25px;font-size:1rem;font-weight:700;cursor:pointer;transition:all .4s cubic-bezier(.23,1,.32,1);margin-top:.5rem;box-shadow:0 4px 25px rgba(201,168,76,.35);}
        .btn-submit:hover{transform:translateY(-3px) scale(1.02);box-shadow:0 8px 40px rgba(201,168,76,.5);}
        .back-link{display:block;text-align:center;margin-top:1rem;color:var(--text-muted);text-decoration:none;font-size:.86rem;transition:color .2s;}
        .back-link:hover{color:var(--gold);}
        .no-booking-notice{text-align:center;padding:2rem 1rem;}
        .no-booking-notice .notice-icon{font-size:2.5rem;display:block;margin-bottom:1rem;}
        .no-booking-notice p{color:var(--text-muted);font-size:.92rem;margin-bottom:1.5rem;line-height:1.6;}
        .btn-book{display:inline-block;padding:.75rem 2rem;background:linear-gradient(135deg,var(--gold),var(--gold-light));color:#0a0e18;border-radius:25px;font-weight:700;text-decoration:none;font-size:.92rem;transition:all .3s;box-shadow:0 4px 15px rgba(201,168,76,.3);}
        .btn-book:hover{transform:translateY(-2px);box-shadow:0 6px 25px rgba(201,168,76,.4);}
        @keyframes fadeUp{from{opacity:0;transform:translateY(35px)}to{opacity:1;transform:translateY(0)}}
    </style>
</head>
<body>
<jsp:include page="../navbar.jsp"/>
<div class="page">
    <div class="review-card">
        <div class="card-logo"><span class="card-icon">✍️</span><div class="card-title">Share Your Experience</div><div class="card-sub">Your review helps other guests make the right choice</div></div>
        <c:choose>
            <c:when test="${not hasBookings}">
                <div class="no-booking-notice"><span class="notice-icon">🏨</span><p>You can only review rooms you've <strong>stayed in</strong>.<br>Book a room first, then come back to share your experience!</p><a href="/room/list" class="btn-book">Browse &amp; Book a Room</a></div>
            </c:when>
            <c:otherwise>
                <form action="/review/submit" method="post">
                    <div class="form-group"><label for="roomId">Room You Stayed In</label><select id="roomId" name="roomId" required><option value="">Select the room you booked...</option><c:forEach var="room" items="${rooms}"><option value="${room.roomId}">${room.displayType} Room ${room.roomNumber} (${room.description} view)</option></c:forEach></select></div>
                    <div class="form-group"><label>Rating</label><div class="star-group"><input type="radio" id="s5" name="rating" value="5"><label for="s5">★</label><input type="radio" id="s4" name="rating" value="4"><label for="s4">★</label><input type="radio" id="s3" name="rating" value="3"><label for="s3">★</label><input type="radio" id="s2" name="rating" value="2"><label for="s2">★</label><input type="radio" id="s1" name="rating" value="1" required><label for="s1">★</label></div><div class="star-selected-label" id="starLabel">Click to rate</div></div>
                    <div class="form-group"><label for="comment">Your Review</label><textarea id="comment" name="comment" placeholder="Tell us about your stay... What did you love?" required minlength="10"></textarea></div>
                    <button type="submit" class="btn-submit">Submit Review →</button>
                </form>
            </c:otherwise>
        </c:choose>
        <a href="/review/all" class="back-link">← Back to all reviews</a>
    </div>
</div>
<script>
const t=localStorage.getItem('roomie-theme')||'dark';document.documentElement.setAttribute('data-theme',t);
const labels=['1 star – Poor','2 stars – Fair','3 stars – Good','4 stars – Great','5 stars – Excellent!'];
document.querySelectorAll('.star-group input').forEach(inp=>{inp.addEventListener('change',function(){document.getElementById('starLabel').textContent=labels[this.value-1];});});
</script>
</body>
</html>
