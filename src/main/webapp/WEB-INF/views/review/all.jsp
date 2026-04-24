<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Guest Reviews – Roomie</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        :root{--bg:#060a12;--bg2:#0a1020;--bg3:#0e1830;--surface:rgba(255,255,255,0.04);--gold:#c9a84c;--gold-light:#e4c470;--text:#e2e8f0;--text-muted:#8ba3c2;--text-faint:#4a6285;--border:rgba(201,168,76,0.12);--radius:20px;--nav-height:70px;--shadow:0 8px 32px rgba(0,0,0,0.5);--glow:0 0 60px rgba(201,168,76,0.12);--glass-bg:rgba(255,255,255,0.04);--glass-border:rgba(255,255,255,0.08);--glass-blur:blur(24px);}
        [data-theme="light"]{--bg:#f0f4f8;--bg2:#e8edf5;--bg3:#dde5f0;--surface:rgba(255,255,255,0.7);--text:#1e293b;--text-muted:#4b6080;--text-faint:#8ea3bf;--border:rgba(30,58,95,0.1);--shadow:0 8px 32px rgba(0,0,0,0.08);--glow:0 0 60px rgba(201,168,76,0.08);--glass-bg:rgba(255,255,255,0.5);--glass-border:rgba(30,58,95,0.1);--glass-blur:blur(20px);}
        body{font-family:'Plus Jakarta Sans',sans-serif;background:var(--bg);color:var(--text);padding-top:var(--nav-height);overflow-x:hidden;transition:background .5s,color .5s;}
        .hero-bar{position:relative;background:linear-gradient(135deg,var(--bg2),var(--bg3));border-bottom:1px solid var(--border);padding:4rem 1.5rem;text-align:center;overflow:hidden;}
        .hero-bar::before{content:'';position:absolute;inset:0;background:radial-gradient(ellipse at 50% 0%,rgba(201,168,76,.1) 0%,transparent 60%);pointer-events:none;}
        [data-theme="light"] .hero-bar{background:linear-gradient(135deg,#1e3a5f,#2e5fa3);}
        [data-theme="light"] .hero-title,[data-theme="light"] .hero-sub{color:#fff;}
        [data-theme="light"] .hero-sub{color:rgba(255,255,255,.7);}
        .hero-title{font-family:'Outfit',sans-serif;font-size:2.5rem;font-weight:700;position:relative;margin-bottom:.5rem;animation:fadeUp .7s ease both;}
        .hero-sub{color:var(--text-muted);font-size:1rem;position:relative;animation:fadeUp .7s .1s ease both;}
        .rating-summary{display:flex;align-items:center;justify-content:center;gap:1rem;margin-top:1.5rem;position:relative;animation:fadeUp .7s .2s ease both;}
        .big-rating{font-family:'Outfit',sans-serif;font-size:3.5rem;font-weight:700;color:var(--gold);}
        .rating-stars{font-size:1.4rem;color:var(--gold);letter-spacing:3px;}
        .rating-count{color:var(--text-muted);font-size:.9rem;}
        .container{max-width:1200px;margin:0 auto;padding:3rem 1.5rem;}
        .section-actions{display:flex;justify-content:flex-end;margin-bottom:2rem;}
        .btn-write{padding:.65rem 1.5rem;background:linear-gradient(135deg,var(--gold),var(--gold-light));color:#0a0e18;border-radius:25px;text-decoration:none;font-weight:700;font-size:.88rem;transition:all .3s;box-shadow:0 4px 15px rgba(201,168,76,.3);}
        .btn-write:hover{transform:translateY(-2px);box-shadow:0 6px 25px rgba(201,168,76,.4);}
        .reviews-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));gap:1.5rem;}
        .review-card{background:var(--glass-bg);backdrop-filter:var(--glass-blur);border:1px solid var(--glass-border);border-radius:var(--radius);padding:2rem;transition:all .4s cubic-bezier(.23,1,.32,1);position:relative;overflow:hidden;}
        .review-card::before{content:'"';position:absolute;top:.8rem;right:1.5rem;font-family:'Outfit',serif;font-size:4rem;color:rgba(201,168,76,.1);line-height:1;}
        .review-card:hover{transform:translateY(-5px);border-color:rgba(201,168,76,.25);box-shadow:0 10px 30px rgba(0,0,0,.2),var(--glow);}
        .review-stars{color:var(--gold);font-size:1rem;letter-spacing:2px;margin-bottom:.8rem;}
        .review-comment{font-size:.9rem;color:var(--text-muted);line-height:1.7;margin-bottom:1.2rem;font-style:italic;}
        .review-author{display:flex;align-items:center;gap:.8rem;}
        .review-avatar{width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,#9a7a30,#c9a84c);display:flex;align-items:center;justify-content:center;font-weight:700;font-size:.9rem;color:#0a0e18;flex-shrink:0;}
        .review-name{font-weight:600;font-size:.88rem;color:var(--text);}
        .review-date{font-size:.74rem;color:var(--text-faint);}
        .review-room{font-size:.74rem;color:var(--gold);margin-top:.2rem;}
        .no-reviews{text-align:center;padding:4rem;border:1px dashed var(--border);border-radius:var(--radius);color:var(--text-muted);background:var(--glass-bg);backdrop-filter:var(--glass-blur);}
        .no-reviews a{color:var(--gold);text-decoration:none;font-weight:600;}
        .flash{padding:.85rem 1rem;border-radius:12px;margin-bottom:2rem;font-size:.86rem;border-left:4px solid;backdrop-filter:blur(12px);}
        .flash-success{background:rgba(22,163,74,.1);border-color:#16a34a;color:#4ade80;}
        .reveal{opacity:0;transform:translateY(40px);transition:opacity .9s cubic-bezier(.23,1,.32,1),transform .9s cubic-bezier(.23,1,.32,1);}
        .reveal.visible{opacity:1;transform:translateY(0);}
        @keyframes fadeUp{from{opacity:0;transform:translateY(35px)}to{opacity:1;transform:translateY(0)}}
        @media(max-width:768px){.reviews-grid{grid-template-columns:1fr;}}
    </style>
</head>
<body>
<jsp:include page="../navbar.jsp"/>
<div class="hero-bar">
    <h1 class="hero-title">Guest Reviews</h1>
    <p class="hero-sub">Real reviews from our valued guests</p>
    <c:if test="${totalReviews > 0 and avgRating > 0}">
        <div class="rating-summary"><div class="big-rating">${String.format("%.1f", avgRating)}</div><div><div class="rating-stars">★★★★★</div><div class="rating-count">${totalReviews} reviews</div></div></div>
    </c:if>
</div>
<div class="container">
    <c:if test="${not empty flash_success}"><div class="flash flash-success">${flash_success}</div></c:if>
    <div class="section-actions">
        <c:choose><c:when test="${not empty sessionScope.loggedCustomer}"><a href="/review/add" class="btn-write">✏️ Write a Review</a></c:when><c:otherwise><a href="/customer/login" class="btn-write">Login to Review</a></c:otherwise></c:choose>
    </div>
    <c:choose>
        <c:when test="${empty reviews}"><div class="no-reviews"><p style="font-size:1.1rem;margin-bottom:1rem;">🌟 No reviews yet. Be the first!</p><a href="/customer/login">Login to write a review</a></div></c:when>
        <c:otherwise>
            <div class="reviews-grid">
                <c:forEach var="review" items="${reviews}" varStatus="loop">
                    <div class="review-card reveal" style="transition-delay:${loop.index * 0.08}s;">
                        <div class="review-stars">${review.stars}</div>
                        <div class="review-comment">"${review.comment}"</div>
                        <div class="review-author"><div class="review-avatar">${review.customerName.charAt(0)}</div><div><div class="review-name">${review.customerName}</div><div class="review-date">${review.reviewDate}</div><div class="review-room">${review.roomId}</div></div></div>
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
