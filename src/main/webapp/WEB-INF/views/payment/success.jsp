<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Payment Successful – Roomie</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        :root{--bg:#060a12;--surface:rgba(255,255,255,0.04);--gold:#c9a84c;--gold-light:#e4c470;--text:#e2e8f0;--text-muted:#8ba3c2;--border:rgba(201,168,76,0.12);--radius:20px;--nav-height:70px;--shadow:0 8px 32px rgba(0,0,0,0.5);--glass-bg:rgba(255,255,255,0.04);--glass-border:rgba(255,255,255,0.08);--glass-blur:blur(24px);}
        [data-theme="light"]{--bg:#f0f4f8;--surface:rgba(255,255,255,0.7);--text:#1e293b;--text-muted:#4b6080;--border:rgba(30,58,95,0.1);--shadow:0 8px 32px rgba(0,0,0,0.08);--glass-bg:rgba(255,255,255,0.5);--glass-border:rgba(30,58,95,0.1);--glass-blur:blur(20px);}
        body{font-family:'Plus Jakarta Sans',sans-serif;background:var(--bg);color:var(--text);padding-top:var(--nav-height);min-height:100vh;display:flex;flex-direction:column;overflow-x:hidden;transition:background .5s,color .5s;}
        .page{flex:1;display:flex;align-items:center;justify-content:center;padding:3rem 1.5rem;position:relative;}
        .page::before{content:'';position:absolute;inset:0;background:radial-gradient(ellipse at 50% 30%,rgba(22,163,74,.06) 0%,transparent 60%);pointer-events:none;}
        .success-card{background:var(--glass-bg);backdrop-filter:var(--glass-blur);border:1px solid rgba(22,163,74,.2);border-radius:24px;padding:3.5rem;max-width:480px;width:100%;text-align:center;box-shadow:var(--shadow);animation:fadeUp .7s ease both;position:relative;overflow:hidden;}
        .success-card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg,transparent,#4ade80,transparent);}
        .success-anim{width:90px;height:90px;border-radius:50%;background:rgba(22,163,74,.1);border:2px solid rgba(22,163,74,.4);display:flex;align-items:center;justify-content:center;margin:0 auto 2rem;font-size:3rem;animation:pop .5s ease;}
        @keyframes pop{0%{transform:scale(0);}80%{transform:scale(1.15);}100%{transform:scale(1);}}
        .success-title{font-family:'Outfit',sans-serif;font-size:2rem;font-weight:700;color:#4ade80;margin-bottom:.8rem;}
        .success-sub{color:var(--text-muted);font-size:.9rem;line-height:1.6;margin-bottom:2rem;}
        .payment-ref{background:rgba(22,163,74,.06);border:1px solid rgba(22,163,74,.15);border-radius:14px;padding:1rem;margin-bottom:2rem;}
        .ref-label{font-size:.74rem;color:var(--text-muted);letter-spacing:1px;text-transform:uppercase;margin-bottom:.3rem;}
        .ref-val{font-family:'Outfit',sans-serif;font-size:1.2rem;color:#4ade80;font-weight:700;}
        .actions{display:flex;flex-direction:column;gap:.8rem;}
        .btn-primary{padding:.9rem;background:linear-gradient(135deg,var(--gold),var(--gold-light));color:#0a0e18;border-radius:25px;text-decoration:none;font-weight:700;font-size:.95rem;transition:all .4s cubic-bezier(.23,1,.32,1);display:block;box-shadow:0 4px 25px rgba(201,168,76,.35);}
        .btn-primary:hover{transform:translateY(-3px);box-shadow:0 8px 40px rgba(201,168,76,.5);}
        .btn-outline{padding:.85rem;border:1.5px solid var(--glass-border);color:var(--text-muted);border-radius:25px;text-decoration:none;font-size:.9rem;display:block;transition:all .3s;backdrop-filter:blur(8px);}
        .btn-outline:hover{border-color:var(--gold);color:var(--gold);}
        @keyframes fadeUp{from{opacity:0;transform:translateY(35px)}to{opacity:1;transform:translateY(0)}}
    </style>
</head>
<body>
<jsp:include page="../navbar.jsp"/>
<div class="page">
    <div class="success-card">
        <div class="success-anim">✅</div>
        <h1 class="success-title">Payment Successful!</h1>
        <p class="success-sub">Your booking has been confirmed and your room is reserved. We look forward to welcoming you!</p>
        <div class="payment-ref"><div class="ref-label">Payment Reference</div><div class="ref-val">${paymentId}</div></div>
        <div class="actions">
            <a href="/reservation/my" class="btn-primary">View My Bookings</a>
            <a href="/review/add" class="btn-outline">Write a Review</a>
            <a href="/" class="btn-outline">Back to Home</a>
        </div>
    </div>
</div>
<script>
const t=localStorage.getItem('roomie-theme')||'dark';document.documentElement.setAttribute('data-theme',t);
(function(){const c=['#c9a84c','#4ade80','#38bdf8','#f87171','#a78bfa'];for(let i=0;i<60;i++){const el=document.createElement('div');el.style.cssText='position:fixed;top:-10px;left:'+Math.random()*100+'vw;width:8px;height:8px;background:'+c[Math.floor(Math.random()*c.length)]+';border-radius:2px;animation:fall '+(Math.random()*3+2)+'s '+(Math.random()*2)+'s ease both;z-index:9999;';document.body.appendChild(el);setTimeout(()=>el.remove(),6e3);}const s=document.createElement('style');s.textContent='@keyframes fall{to{transform:translateY(100vh) rotate(720deg);opacity:0;}}';document.head.appendChild(s);})();
</script>
</body>
</html>
