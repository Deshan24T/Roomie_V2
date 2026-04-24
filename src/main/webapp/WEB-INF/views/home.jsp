<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Roomie – Weightless luxury. Elevated living. Discover premium hotel rooms floating above Sri Lanka's most breathtaking landscapes.">
    <title>Roomie – Weightless Luxury. Elevated Living.</title>
    <meta name="view-transition" content="same-origin" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
/* ══════════════════════════════════════════════════════════════
   0. RESET & DESIGN TOKENS
   ══════════════════════════════════════════════════════════════ */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
:root {
    --bg:           #060a12;
    --bg2:          #0a1020;
    --bg3:          #0e1830;
    --bg4:          #132040;
    --surface:      rgba(255,255,255,0.04);
    --surface2:     rgba(255,255,255,0.07);
    --surface3:     rgba(255,255,255,0.10);
    --gold:         #c9a84c;
    --gold-light:   #e4c470;
    --gold-dark:    #9a7a30;
    --gold-glow:    rgba(201,168,76,0.25);
    --text:         #e2e8f0;
    --text-muted:   #8ba3c2;
    --text-faint:   #4a6285;
    --border:       rgba(201,168,76,0.12);
    --border2:      rgba(255,255,255,0.08);
    --radius:       20px;
    --nav-height:   70px;
    --shadow:       0 8px 32px rgba(0,0,0,0.5);
    --glow:         0 0 60px rgba(201,168,76,0.12);
    --glass-bg:     rgba(255,255,255,0.04);
    --glass-border: rgba(255,255,255,0.08);
    --glass-blur:   blur(24px);
}
[data-theme="light"] {
    --bg:           #f0f4f8;
    --bg2:          #e8edf5;
    --bg3:          #dde5f0;
    --bg4:          #d0dae8;
    --surface:      rgba(255,255,255,0.7);
    --surface2:     rgba(255,255,255,0.85);
    --surface3:     rgba(255,255,255,0.95);
    --text:         #1e293b;
    --text-muted:   #4b6080;
    --text-faint:   #8ea3bf;
    --border:       rgba(30,58,95,0.1);
    --border2:      rgba(30,58,95,0.08);
    --shadow:       0 8px 32px rgba(0,0,0,0.08);
    --glow:         0 0 60px rgba(201,168,76,0.08);
    --glass-bg:     rgba(255,255,255,0.5);
    --glass-border: rgba(30,58,95,0.1);
    --glass-blur:   blur(20px);
}
html { scroll-behavior: smooth; }
body {
    font-family: 'Plus Jakarta Sans', sans-serif;
    background: var(--bg);
    color: var(--text);
    overflow-x: hidden;
    transition: background 0.5s, color 0.5s;
}

/* ══════════════════════════════════════════════════════════════
   1. (REMOVED — Custom Cursor)
   ══════════════════════════════════════════════════════════════ */

/* ══════════════════════════════════════════════════════════════
   2. STARDUST CANVAS
   ══════════════════════════════════════════════════════════════ */
#stardustCanvas {
    position: fixed;
    top: 0; left: 0;
    width: 100vw; height: 100vh;
    pointer-events: none;
    z-index: 1;
    opacity: 0.7;
}
[data-theme="light"] #stardustCanvas { opacity: 0.3; }

/* ══════════════════════════════════════════════════════════════
   3. ORBITAL NAVIGATION
   ══════════════════════════════════════════════════════════════ */
.orbital-nav {
    position: fixed;
    right: 1.5rem;
    top: 50%;
    transform: translateY(-50%);
    z-index: 999;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0;
}
.orbit-track {
    position: absolute;
    width: 2px;
    height: 100%;
    background: linear-gradient(to bottom, transparent, rgba(201,168,76,0.15), transparent);
    border-radius: 1px;
}
.orbit-dot {
    width: 12px; height: 12px;
    border-radius: 50%;
    border: 1.5px solid rgba(201,168,76,0.25);
    background: transparent;
    cursor: pointer;
    transition: all 0.4s cubic-bezier(0.23,1,0.32,1);
    position: relative;
    margin: 10px 0;
    outline: none;
}
.orbit-dot::before {
    content: '';
    position: absolute;
    inset: 2px;
    border-radius: 50%;
    background: transparent;
    transition: background 0.4s;
}
.orbit-dot.active {
    border-color: var(--gold);
    box-shadow: 0 0 16px rgba(201,168,76,0.4), 0 0 4px rgba(201,168,76,0.6);
    transform: scale(1.3);
}
.orbit-dot.active::before {
    background: var(--gold);
}
.orbit-dot:hover {
    border-color: var(--gold-light);
    transform: scale(1.2);
}
.orbit-label {
    position: absolute;
    right: 24px;
    white-space: nowrap;
    font-size: 0.7rem;
    font-weight: 500;
    color: var(--gold);
    letter-spacing: 1.5px;
    text-transform: uppercase;
    opacity: 0;
    transform: translateX(8px);
    transition: opacity 0.3s, transform 0.3s;
    pointer-events: none;
}
.orbit-dot:hover .orbit-label,
.orbit-dot.active .orbit-label {
    opacity: 1;
    transform: translateX(0);
}
@media (max-width: 900px) {
    .orbital-nav { display: none; }
}

/* ══════════════════════════════════════════════════════════════
   4. HERO — THE ZENITH ENTRANCE
   ══════════════════════════════════════════════════════════════ */
.hero {
    position: relative;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    padding: calc(var(--nav-height) + 2rem) 1.5rem 4rem;
    z-index: 2;
}
.hero-bg {
    position: absolute; inset: 0;
    background: url('/images/hero-bg.png') center/cover no-repeat;
    filter: brightness(0.3) saturate(0.6);
    transform: scale(1.08);
    animation: heroZoom 25s ease-in-out infinite alternate;
}
.hero-overlay {
    position: absolute; inset: 0;
    background:
        radial-gradient(ellipse at 30% 20%, rgba(201,168,76,0.08) 0%, transparent 60%),
        radial-gradient(ellipse at 70% 80%, rgba(100,140,200,0.06) 0%, transparent 50%),
        linear-gradient(180deg, rgba(6,10,18,0.7) 0%, rgba(6,10,18,0.4) 40%, rgba(6,10,18,0.85) 100%);
}
.hero-mist {
    position: absolute; inset: 0;
    background:
        radial-gradient(ellipse at 20% 90%, rgba(255,255,255,0.03) 0%, transparent 50%),
        radial-gradient(ellipse at 80% 85%, rgba(201,168,76,0.04) 0%, transparent 40%);
    animation: mistDrift 12s ease-in-out infinite alternate;
}
.hero-content {
    position: relative; z-index: 3;
    text-align: center;
    max-width: 950px;
    margin: -2rem auto 0;
}
.brand-hero-logo {
    height: 120px; width: auto; object-fit: contain;
    margin: 0 auto 0.5rem;
    display: block;
    animation: fadeDown 0.8s ease both;
    filter: drop-shadow(0 0 30px rgba(201,168,76,0.15));
}
.hero-badge {
    display: inline-flex; align-items: center; gap: 0.6rem;
    background: rgba(255,255,255,0.04);
    backdrop-filter: blur(24px);
    -webkit-backdrop-filter: blur(24px);
    border: 1px solid rgba(255,255,255,0.08);
    border-radius: 50px;
    padding: 0.5rem 1.4rem;
    margin-bottom: 2rem;
    font-size: 0.72rem;
    color: var(--gold);
    letter-spacing: 3px;
    text-transform: uppercase;
    animation: fadeDown 0.8s 0.1s ease both;
}
/* Hero always uses dark styling regardless of theme (dark bg image behind) */
[data-theme="light"] .hero .hero-badge {
    background: rgba(0,0,0,0.25);
    border-color: rgba(255,255,255,0.15);
}
[data-theme="light"] .hero .hero-title { color: #fff; }
[data-theme="light"] .hero .hero-title .thin-text {
    color: rgba(255,255,255,0.5);
    -webkit-text-fill-color: rgba(255,255,255,0.5);
}
[data-theme="light"] .hero .hero-subtitle { color: rgba(255,255,255,0.6); }
[data-theme="light"] .hero .btn-outline-gold {
    background: rgba(0,0,0,0.2);
    border-color: rgba(255,255,255,0.25);
    color: #fff;
}
[data-theme="light"] .hero .btn-outline-gold:hover {
    border-color: var(--gold);
    color: var(--gold);
    background: rgba(201,168,76,0.12);
}
[data-theme="light"] .hero .scroll-cue-text { color: rgba(255,255,255,0.3); }
[data-theme="light"] .hero .scroll-cue-line {
    background: linear-gradient(to bottom, rgba(201,168,76,0.5), transparent);
}
[data-theme="light"] .hero .brand-hero-logo {
    filter: drop-shadow(0 0 30px rgba(201,168,76,0.15)) brightness(1.1);
}
.hero-title {
    font-family: 'Outfit', sans-serif;
    font-size: clamp(2.8rem, 8vw, 6rem);
    font-weight: 800;
    line-height: 1.02;
    color: #fff;
    margin-bottom: 1.5rem;
    animation: fadeUp 1s 0.2s ease both;
    letter-spacing: -1px;
}
.hero-title .gold-text {
    background: linear-gradient(135deg, var(--gold-light) 0%, var(--gold) 50%, var(--gold-dark) 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    filter: drop-shadow(0 0 40px rgba(201,168,76,0.3));
}
.hero-title .thin-text {
    font-weight: 300;
    font-size: 0.55em;
    display: block;
    letter-spacing: 5px;
    text-transform: uppercase;
    color: rgba(255,255,255,0.5);
    -webkit-text-fill-color: rgba(255,255,255,0.5);
    margin-top: 0.3rem;
}
.hero-subtitle {
    font-size: clamp(0.95rem, 2.5vw, 1.2rem);
    color: rgba(255,255,255,0.55);
    font-weight: 300;
    letter-spacing: 1px;
    max-width: 550px;
    margin: 0 auto 3rem;
    line-height: 1.7;
    animation: fadeUp 1s 0.4s ease both;
}
.hero-actions {
    display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;
    animation: fadeUp 1s 0.6s ease both;
}
.btn-gold {
    padding: 0.85rem 2.4rem;
    background: linear-gradient(135deg, var(--gold), var(--gold-light));
    color: #0a0e18;
    border-radius: 50px;
    font-weight: 700;
    font-size: 0.9rem;
    text-decoration: none;
    letter-spacing: 0.5px;
    transition: all 0.4s cubic-bezier(0.23,1,0.32,1);
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    box-shadow: 0 4px 25px rgba(201,168,76,0.35);
    border: none;
    position: relative;
    overflow: hidden;
}
.btn-gold::before {
    content: '';
    position: absolute;
    inset: 0;
    background: linear-gradient(135deg, var(--gold-light), #fff, var(--gold-light));
    opacity: 0;
    transition: opacity 0.4s;
}
.btn-gold:hover {
    transform: translateY(-3px) scale(1.02);
    box-shadow: 0 8px 40px rgba(201,168,76,0.5);
}
.btn-gold:hover::before { opacity: 0.15; }
.btn-outline-gold {
    padding: 0.85rem 2.4rem;
    background: var(--glass-bg);
    backdrop-filter: var(--glass-blur);
    -webkit-backdrop-filter: var(--glass-blur);
    border: 1.5px solid rgba(255,255,255,0.2);
    color: #fff;
    border-radius: 50px;
    font-weight: 600;
    font-size: 0.9rem;
    text-decoration: none;
    transition: all 0.4s cubic-bezier(0.23,1,0.32,1);
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
}
.btn-outline-gold:hover {
    border-color: var(--gold);
    color: var(--gold);
    transform: translateY(-3px);
    background: rgba(201,168,76,0.08);
}
.scroll-cue {
    position: absolute;
    bottom: 2rem;
    left: 50%;
    transform: translateX(-50%);
    z-index: 3;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.5rem;
    animation: fadeUp 1s 1s ease both;
}
.scroll-cue-text {
    font-size: 0.6rem;
    letter-spacing: 3px;
    text-transform: uppercase;
    color: rgba(255,255,255,0.3);
}
.scroll-cue-line {
    width: 1px;
    height: 40px;
    background: linear-gradient(to bottom, rgba(201,168,76,0.5), transparent);
    animation: scrollPulse 2s ease-in-out infinite;
}

/* ══════════════════════════════════════════════════════════════
   5. CLOUD TRANSITIONS
   ══════════════════════════════════════════════════════════════ */
.cloud-transition {
    position: relative;
    height: 120px;
    z-index: 2;
    overflow: hidden;
    background: transparent;
}
.cloud-transition::before,
.cloud-transition::after {
    content: '';
    position: absolute;
    left: -10%;
    width: 120%;
    height: 100%;
}
.cloud-transition::before {
    top: -40%;
    background: radial-gradient(ellipse at 30% 50%, rgba(201,168,76,0.06) 0%, transparent 70%),
                radial-gradient(ellipse at 70% 60%, rgba(100,150,220,0.04) 0%, transparent 60%);
    filter: blur(40px);
    animation: cloudDrift1 15s ease-in-out infinite alternate;
}
.cloud-transition::after {
    bottom: -40%;
    background: radial-gradient(ellipse at 50% 50%, rgba(255,255,255,0.03) 0%, transparent 70%);
    filter: blur(50px);
    animation: cloudDrift2 18s ease-in-out infinite alternate;
}

/* ══════════════════════════════════════════════════════════════
   6. SHOWCASE — SPLIT-SCREEN EXPERIENCE
   ══════════════════════════════════════════════════════════════ */
.showcase {
    position: relative;
    z-index: 2;
    background: var(--bg);
}
.showcase-header {
    text-align: center;
    padding: 5rem 1.5rem 2rem;
}
.showcase-tag {
    display: inline-block;
    font-size: 0.68rem;
    letter-spacing: 4px;
    text-transform: uppercase;
    color: var(--gold);
    margin-bottom: 1rem;
}
.showcase-heading {
    font-family: 'Outfit', sans-serif;
    font-size: clamp(2rem, 5vw, 3.5rem);
    font-weight: 700;
    color: var(--text);
    margin-bottom: 0.5rem;
    line-height: 1.1;
}
.showcase-heading .gold-text {
    background: linear-gradient(135deg, var(--gold-light), var(--gold));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}
.showcase-container {
    display: flex;
    max-width: 100%;
    position: relative;
}
.showcase-left {
    width: 55%;
    height: 100vh;
    position: sticky;
    top: 0;
    overflow: hidden;
}
.showcase-img-stack {
    position: relative;
    width: 100%;
    height: 100%;
}
.showcase-img-item {
    position: absolute;
    inset: 0;
    opacity: 0;
    transition: opacity 1s cubic-bezier(0.23,1,0.32,1), transform 1.2s cubic-bezier(0.23,1,0.32,1);
    transform: scale(1.05);
}
.showcase-img-item.active {
    opacity: 1;
    transform: scale(1);
}
.showcase-img-item img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.showcase-img-overlay {
    position: absolute;
    inset: 0;
}
.showcase-img-overlay.coastal {
    background: linear-gradient(135deg,
        rgba(6,10,18,0.82) 0%,
        rgba(10,50,90,0.35) 50%,
        rgba(6,10,18,0.75) 100%);
}
.showcase-img-overlay.hills {
    background: linear-gradient(135deg,
        rgba(6,18,12,0.82) 0%,
        rgba(15,80,50,0.35) 50%,
        rgba(6,18,12,0.75) 100%);
}
.showcase-img-overlay.jungle {
    background: linear-gradient(135deg,
        rgba(18,12,6,0.82) 0%,
        rgba(80,60,15,0.35) 50%,
        rgba(18,12,6,0.75) 100%);
}
/* Right-edge gradient for blending into right panel */
.showcase-img-item::after {
    content: '';
    position: absolute;
    top: 0; right: 0;
    width: 30%;
    height: 100%;
    background: linear-gradient(to right, transparent, var(--bg));
    pointer-events: none;
}
.showcase-right {
    width: 45%;
    position: relative;
}
.showcase-panel {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 4rem 3.5rem 4rem 2.5rem;
    position: relative;
}
.showcase-panel-inner {
    opacity: 0;
    transform: translateY(50px);
    transition: opacity 0.8s cubic-bezier(0.23,1,0.32,1), transform 0.8s cubic-bezier(0.23,1,0.32,1);
}
.showcase-panel.in-view .showcase-panel-inner {
    opacity: 1;
    transform: translateY(0);
}
.showcase-location {
    font-size: 0.65rem;
    letter-spacing: 4px;
    text-transform: uppercase;
    color: var(--gold);
    margin-bottom: 0.8rem;
    display: flex;
    align-items: center;
    gap: 0.6rem;
}
.showcase-location::before {
    content: '';
    display: block;
    width: 24px; height: 1px;
    background: var(--gold);
}
.showcase-title {
    font-family: 'Outfit', sans-serif;
    font-size: clamp(2rem, 4vw, 3rem);
    font-weight: 700;
    color: var(--text);
    line-height: 1.1;
    margin-bottom: 1rem;
}
.showcase-tagline {
    font-family: 'Outfit', sans-serif;
    font-size: clamp(1rem, 2vw, 1.3rem);
    font-weight: 300;
    font-style: italic;
    color: var(--gold-light);
    margin-bottom: 1.5rem;
    letter-spacing: 0.5px;
}
.showcase-desc {
    font-size: 0.92rem;
    color: var(--text-muted);
    line-height: 1.8;
    margin-bottom: 2rem;
    max-width: 400px;
}
.showcase-price {
    display: inline-flex;
    align-items: baseline;
    gap: 0.4rem;
    padding: 0.8rem 1.5rem;
    background: var(--glass-bg);
    backdrop-filter: var(--glass-blur);
    -webkit-backdrop-filter: var(--glass-blur);
    border: 1px solid var(--glass-border);
    border-radius: 16px;
    margin-bottom: 2rem;
    animation: bob 3.5s ease-in-out infinite;
}
.showcase-price-amount {
    font-family: 'Outfit', sans-serif;
    font-size: 1.8rem;
    font-weight: 700;
    color: var(--gold);
}
.showcase-price-label {
    font-size: 0.8rem;
    color: var(--text-muted);
}
.showcase-features-list {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 0.6rem 1rem;
    margin-bottom: 2rem;
    list-style: none;
}
.showcase-feature-item {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 0.82rem;
    color: var(--text-muted);
    line-height: 1.4;
}
.showcase-feature-icon {
    font-size: 0.9rem;
    flex-shrink: 0;
    width: 22px;
    text-align: center;
}
.showcase-highlight {
    display: flex;
    align-items: center;
    gap: 0.6rem;
    padding: 0.7rem 1rem;
    background: rgba(201,168,76,0.06);
    border: 1px solid rgba(201,168,76,0.12);
    border-radius: 12px;
    margin-bottom: 1.5rem;
    font-size: 0.82rem;
    color: var(--gold-light);
}
.showcase-highlight-icon {
    font-size: 1.2rem;
}
.showcase-highlight-text {
    line-height: 1.4;
}
.showcase-highlight-text strong {
    display: block;
    color: var(--gold);
    font-size: 0.78rem;
    letter-spacing: 1px;
    text-transform: uppercase;
    margin-bottom: 0.1rem;
}
.showcase-cta {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    color: var(--gold);
    font-weight: 600;
    font-size: 0.9rem;
    text-decoration: none;
    letter-spacing: 0.5px;
    transition: all 0.3s;
    padding: 0.6rem 0;
    border-bottom: 1px solid rgba(201,168,76,0.3);
}
.showcase-cta:hover {
    color: var(--gold-light);
    border-color: var(--gold-light);
    gap: 0.8rem;
}
.showcase-cta-arrow {
    transition: transform 0.3s;
    font-size: 1.1rem;
}
.showcase-cta:hover .showcase-cta-arrow {
    transform: translateX(4px);
}

/* ══════════════════════════════════════════════════════════════
   7. ROOM TYPE HEADERS & ROOMS GRID SECTION
   ══════════════════════════════════════════════════════════════ */
.room-type-header {
    display: flex;
    align-items: center;
    gap: 1rem;
    margin-bottom: 2rem;
    padding-bottom: 1rem;
    border-bottom: 1px solid var(--border);
}
.room-type-icon {
    font-size: 2rem;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 52px; height: 52px;
    border-radius: 14px;
    background: rgba(201,168,76,0.08);
    border: 1px solid rgba(201,168,76,0.15);
    flex-shrink: 0;
}
.room-type-name {
    font-family: 'Outfit', sans-serif;
    font-size: 1.4rem;
    font-weight: 700;
    color: var(--text);
    margin-bottom: 0.15rem;
}
.room-type-sub {
    font-size: 0.82rem;
    color: var(--gold);
    font-style: italic;
    font-weight: 400;
    letter-spacing: 0.3px;
}
.section { padding: 6rem 1.5rem; position: relative; z-index: 2; }
.section-dark { background: var(--bg2); }
.section-darker { background: var(--bg3); }
.container { max-width: 1300px; margin: 0 auto; }
.section-header { text-align: center; margin-bottom: 3.5rem; }
.section-tag {
    display: inline-block;
    font-size: 0.65rem;
    letter-spacing: 4px;
    text-transform: uppercase;
    color: var(--gold);
    margin-bottom: 0.8rem;
}
.section-title {
    font-family: 'Outfit', sans-serif;
    font-size: clamp(2rem, 4vw, 3rem);
    font-weight: 700;
    color: var(--text);
    margin-bottom: 0.5rem;
    line-height: 1.15;
}
.section-subtitle {
    font-family: 'Outfit', sans-serif;
    font-size: clamp(0.95rem, 2vw, 1.15rem);
    font-weight: 300;
    font-style: italic;
    color: var(--gold-light);
    margin-bottom: 1rem;
    letter-spacing: 0.5px;
}
.section-divider {
    width: 50px; height: 2px;
    background: linear-gradient(90deg, transparent, var(--gold), transparent);
    margin: 0 auto; border-radius: 2px;
}
.rooms-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
    gap: 2rem;
}
.room-card {
    background: var(--glass-bg);
    backdrop-filter: var(--glass-blur);
    -webkit-backdrop-filter: var(--glass-blur);
    border-radius: var(--radius);
    overflow: hidden;
    border: 1px solid var(--glass-border);
    transition: transform 0.5s cubic-bezier(0.23,1,0.32,1),
                box-shadow 0.5s cubic-bezier(0.23,1,0.32,1),
                border-color 0.4s;
    position: relative;
}
.room-card:hover {
    transform: translateY(-10px) scale(1.01);
    box-shadow: 0 20px 50px rgba(0,0,0,0.4), var(--glow);
    border-color: rgba(201,168,76,0.35);
}
.room-img-wrap { position: relative; height: 240px; overflow: hidden; }
.room-img {
    width: 100%; height: 100%; object-fit: cover;
    transition: transform 0.8s cubic-bezier(0.23,1,0.32,1);
}
.room-card:hover .room-img { transform: scale(1.08); }
.room-type-badge {
    position: absolute; top: 1rem; left: 1rem;
    background: rgba(201,168,76,0.9); color: #0a0e18;
    padding: 0.3rem 0.9rem; border-radius: 20px;
    font-size: 0.72rem; font-weight: 700; letter-spacing: 1.5px; text-transform: uppercase;
}
.room-status-badge {
    position: absolute; top: 1rem; right: 1rem;
    background: rgba(22,163,74,0.85); color: #fff;
    padding: 0.28rem 0.8rem; border-radius: 20px;
    font-size: 0.7rem; font-weight: 600;
    backdrop-filter: blur(8px);
}
.room-status-badge.occupied { background: rgba(220,38,38,0.85); }
.room-body { padding: 1.4rem 1.6rem 1.8rem; }
.room-number {
    font-size: 0.72rem; color: var(--text-faint);
    margin-bottom: 0.4rem; font-weight: 500; letter-spacing: 2px;
}
.room-name {
    font-family: 'Outfit', sans-serif; font-size: 1.3rem;
    font-weight: 600; color: var(--text); margin-bottom: 0.5rem;
}
.room-desc {
    font-size: 0.85rem; color: var(--text-muted);
    margin-bottom: 1rem; line-height: 1.6;
}
.room-amenities { display: flex; flex-wrap: wrap; gap: 0.4rem; margin-bottom: 1.2rem; }
.amenity-tag {
    background: rgba(201,168,76,0.08);
    border: 1px solid rgba(201,168,76,0.18);
    color: var(--gold);
    border-radius: 20px;
    padding: 0.2rem 0.7rem;
    font-size: 0.7rem;
    font-weight: 500;
}
.room-footer { display: flex; align-items: center; justify-content: space-between; }
.room-price { color: var(--gold); font-family: 'Outfit', sans-serif; }
.room-price strong { font-size: 1.5rem; }
.room-price span { font-size: 0.78rem; color: var(--text-muted); font-family: 'Plus Jakarta Sans', sans-serif; }
.room-price-float {
    animation: bob 3s ease-in-out infinite;
    display: inline-block;
}
.room-capacity { display: flex; align-items: center; gap: 0.3rem; color: var(--text-muted); font-size: 0.8rem; }
.btn-view {
    padding: 0.55rem 1.4rem;
    background: transparent;
    border: 1.5px solid rgba(201,168,76,0.4);
    color: var(--gold);
    border-radius: 25px;
    font-size: 0.82rem;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s cubic-bezier(0.23,1,0.32,1);
    backdrop-filter: blur(8px);
}
.btn-view:hover {
    background: var(--gold);
    color: #0a0e18;
    border-color: var(--gold);
    transform: scale(1.05);
}

/* ══════════════════════════════════════════════════════════════
   8. FEATURES
   ══════════════════════════════════════════════════════════════ */
.features-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 1.5rem; }
.feature-card {
    background: var(--glass-bg);
    backdrop-filter: var(--glass-blur);
    -webkit-backdrop-filter: var(--glass-blur);
    border: 1px solid var(--glass-border);
    border-radius: var(--radius);
    padding: 2.2rem 1.6rem;
    text-align: center;
    transition: all 0.4s cubic-bezier(0.23,1,0.32,1);
    position: relative;
    overflow: hidden;
}
.feature-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 2px;
    background: linear-gradient(90deg, transparent, var(--gold), transparent);
    opacity: 0;
    transition: opacity 0.4s;
}
.feature-card:hover {
    transform: translateY(-8px);
    border-color: rgba(201,168,76,0.3);
    box-shadow: var(--glow);
}
.feature-card:hover::before { opacity: 1; }
.feature-icon {
    font-size: 2.2rem;
    margin-bottom: 1rem;
    display: block;
    animation: bob 4s ease-in-out infinite;
}
.feature-title {
    font-family: 'Outfit', sans-serif;
    font-size: 1.05rem;
    font-weight: 600;
    color: var(--text);
    margin-bottom: 0.6rem;
}
.feature-desc { font-size: 0.84rem; color: var(--text-muted); line-height: 1.65; }

/* ══════════════════════════════════════════════════════════════
   9. REVIEWS
   ══════════════════════════════════════════════════════════════ */
.reviews-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 1.5rem; }
.review-card {
    background: var(--glass-bg);
    backdrop-filter: var(--glass-blur);
    -webkit-backdrop-filter: var(--glass-blur);
    border: 1px solid var(--glass-border);
    border-radius: var(--radius);
    padding: 2rem;
    transition: all 0.4s cubic-bezier(0.23,1,0.32,1);
    position: relative;
}
.review-card::before {
    content: '"';
    position: absolute;
    top: 0.8rem;
    right: 1.5rem;
    font-family: 'Outfit', serif;
    font-size: 4rem;
    color: rgba(201,168,76,0.1);
    line-height: 1;
}
.review-card:hover {
    transform: translateY(-5px);
    border-color: rgba(201,168,76,0.25);
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
}
.review-stars { color: var(--gold); font-size: 0.95rem; margin-bottom: 1rem; letter-spacing: 2px; }
.review-comment {
    font-size: 0.9rem; color: var(--text-muted);
    line-height: 1.7; margin-bottom: 1.4rem; font-style: italic;
}
.review-author { display: flex; align-items: center; gap: 0.8rem; }
.review-avatar {
    width: 40px; height: 40px; border-radius: 50%;
    background: linear-gradient(135deg, var(--gold-dark), var(--gold));
    display: flex; align-items: center; justify-content: center;
    font-weight: 700; font-size: 0.85rem; color: #0a0e18;
    flex-shrink: 0;
}
.review-name { font-weight: 600; font-size: 0.88rem; color: var(--text); }
.review-date { font-size: 0.72rem; color: var(--text-faint); }
.reviews-empty {
    text-align: center; color: var(--text-muted);
    padding: 3rem;
    border: 1px dashed var(--border);
    border-radius: var(--radius);
    background: var(--glass-bg);
    backdrop-filter: var(--glass-blur);
}

/* ══════════════════════════════════════════════════════════════
   10. COUNTER
   ══════════════════════════════════════════════════════════════ */
.counter-section {
    background:
        linear-gradient(135deg, rgba(6,10,18,0.95) 0%, rgba(15,25,45,0.95) 50%, rgba(6,10,18,0.95) 100%),
        radial-gradient(ellipse at 50% 50%, rgba(201,168,76,0.08) 0%, transparent 70%);
    border-top: 1px solid var(--border);
    border-bottom: 1px solid var(--border);
    padding: 5rem 1.5rem;
    position: relative;
    z-index: 2;
}
[data-theme="light"] .counter-section {
    background: linear-gradient(135deg, #1e3a5f, #2e5fa3, #1e3a5f);
}
.counter-grid { display: flex; justify-content: center; gap: 5rem; flex-wrap: wrap; }
.counter-item { text-align: center; }
.counter-num {
    font-family: 'Outfit', sans-serif;
    font-size: 3.5rem;
    font-weight: 800;
    background: linear-gradient(135deg, var(--gold-light), var(--gold));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    display: block;
    line-height: 1;
}
.counter-label {
    font-size: 0.72rem;
    color: rgba(255,255,255,0.45);
    letter-spacing: 3px;
    text-transform: uppercase;
    margin-top: 0.5rem;
}

/* ══════════════════════════════════════════════════════════════
   11. CTA — THE SUMMIT
   ══════════════════════════════════════════════════════════════ */
.cta-section {
    padding: 8rem 1.5rem;
    text-align: center;
    position: relative;
    z-index: 2;
    background: var(--bg);
    overflow: hidden;
}
.cta-section::before {
    content: '';
    position: absolute;
    inset: 0;
    background:
        radial-gradient(ellipse at 50% 50%, rgba(201,168,76,0.1) 0%, transparent 60%),
        radial-gradient(circle at 30% 70%, rgba(100,150,220,0.05) 0%, transparent 50%);
    animation: glowPulse 6s ease-in-out infinite alternate;
}
.cta-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    background: var(--glass-bg);
    backdrop-filter: var(--glass-blur);
    border: 1px solid var(--glass-border);
    border-radius: 50px;
    padding: 0.4rem 1.2rem;
    margin-bottom: 2rem;
    font-size: 0.68rem;
    color: var(--gold);
    letter-spacing: 3px;
    text-transform: uppercase;
}
.cta-title {
    font-family: 'Outfit', sans-serif;
    font-size: clamp(2.2rem, 5vw, 3.5rem);
    font-weight: 800;
    color: var(--text);
    margin-bottom: 1rem;
    position: relative;
    line-height: 1.1;
}
.cta-title .gold-text {
    background: linear-gradient(135deg, var(--gold-light), var(--gold));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}
.cta-subtitle {
    color: var(--text-muted);
    margin-bottom: 2.5rem;
    font-size: 1rem;
    max-width: 500px;
    margin-left: auto;
    margin-right: auto;
    line-height: 1.7;
    position: relative;
}

/* ══════════════════════════════════════════════════════════════
   12. FOOTER — GROUND LEVEL
   ══════════════════════════════════════════════════════════════ */
.footer {
    background: var(--bg2);
    border-top: 1px solid var(--border);
    padding: 4rem 1.5rem 1.5rem;
    position: relative;
    z-index: 2;
}
.footer-grid {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr 1fr;
    gap: 2.5rem;
    max-width: 1300px;
    margin: 0 auto 2.5rem;
}
.footer-brand {
    font-family: 'Outfit', sans-serif;
    font-size: 1.5rem;
    color: var(--gold);
    margin-bottom: 0.8rem;
}
.footer-desc { font-size: 0.86rem; color: var(--text-muted); line-height: 1.7; }
.footer-heading {
    font-size: 0.72rem; letter-spacing: 3px; text-transform: uppercase;
    color: var(--gold); margin-bottom: 1rem; font-weight: 600;
}
.footer-links { list-style: none; }
.footer-links li a {
    color: var(--text-muted); text-decoration: none; font-size: 0.86rem;
    display: block; padding: 0.3rem 0; transition: all 0.3s;
}
.footer-links li a:hover { color: var(--gold); padding-left: 0.3rem; }
.footer-bottom {
    border-top: 1px solid var(--border);
    padding-top: 1.5rem;
    display: flex; justify-content: space-between; align-items: center;
    flex-wrap: wrap; gap: 0.5rem;
    max-width: 1300px; margin: 0 auto;
}
.footer-copy { font-size: 0.78rem; color: var(--text-faint); }

/* ══════════════════════════════════════════════════════════════
   13. ANIMATIONS & KEYFRAMES
   ══════════════════════════════════════════════════════════════ */
@keyframes heroZoom {
    from { transform: scale(1.08); }
    to { transform: scale(1.18); }
}
@keyframes fadeUp {
    from { opacity: 0; transform: translateY(35px); }
    to { opacity: 1; transform: translateY(0); }
}
@keyframes fadeDown {
    from { opacity: 0; transform: translateY(-25px); }
    to { opacity: 1; transform: translateY(0); }
}
@keyframes bob {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-8px); }
}
@keyframes scrollPulse {
    0%, 100% { opacity: 0.3; transform: scaleY(1); }
    50% { opacity: 0.8; transform: scaleY(1.1); }
}
@keyframes mistDrift {
    from { transform: translateX(-3%) translateY(0); }
    to { transform: translateX(3%) translateY(-2%); }
}
@keyframes cloudDrift1 {
    from { transform: translateX(-5%); }
    to { transform: translateX(5%); }
}
@keyframes cloudDrift2 {
    from { transform: translateX(3%); }
    to { transform: translateX(-3%); }
}
@keyframes glowPulse {
    from { opacity: 0.6; }
    to { opacity: 1; }
}

/* Scroll reveal */
.reveal {
    opacity: 0;
    transform: translateY(40px);
    transition: opacity 0.9s cubic-bezier(0.23,1,0.32,1),
                transform 0.9s cubic-bezier(0.23,1,0.32,1);
}
.reveal.visible { opacity: 1; transform: translateY(0); }

/* ══════════════════════════════════════════════════════════════
   14. FLASH MESSAGES
   ══════════════════════════════════════════════════════════════ */
.flash-msg {
    padding: 1rem 1.5rem; border-radius: 12px; margin: 1rem 0; font-size: 0.9rem;
    border-left: 4px solid; backdrop-filter: blur(12px);
}
.flash-success { background: rgba(22,163,74,0.1); border-color: #16a34a; color: #4ade80; }
.flash-error { background: rgba(220,38,38,0.1); border-color: #dc2626; color: #f87171; }

/* ══════════════════════════════════════════════════════════════
   15. RESPONSIVE
   ══════════════════════════════════════════════════════════════ */
@media (max-width: 1024px) {
    .showcase-container { flex-direction: column; }
    .showcase-left {
        width: 100%;
        height: 50vh;
        position: relative;
    }
    .showcase-right { width: 100%; }
    .showcase-panel {
        min-height: auto;
        padding: 3rem 2rem;
    }
    .showcase-img-item::after { display: none; }
}
@media (max-width: 768px) {
    .counter-grid { gap: 2rem; }
    .footer-grid { grid-template-columns: 1fr 1fr; }
    .rooms-grid, .features-grid, .reviews-grid { grid-template-columns: 1fr; }
    .hero-title { letter-spacing: 0; }
    .showcase-panel { padding: 2rem 1.5rem; }
}
@media (max-width: 480px) {
    .footer-grid { grid-template-columns: 1fr; }
    .counter-grid { gap: 1.5rem; }
}
    </style>
</head>
<body>


<!-- ═══ STARDUST CANVAS ═══ -->
<canvas id="stardustCanvas"></canvas>

<!-- ═══ ORBITAL NAVIGATION ═══ -->
<nav class="orbital-nav" id="orbitalNav" aria-label="Section navigation">
    <div class="orbit-track"></div>
    <button class="orbit-dot active" data-section="hero" aria-label="Hero section">
        <span class="orbit-label">Zenith</span>
    </button>
    <button class="orbit-dot" data-section="showcase" aria-label="Showcase section">
        <span class="orbit-label">Ascent</span>
    </button>
    <button class="orbit-dot" data-section="rooms" aria-label="Rooms section">
        <span class="orbit-label">Rooms</span>
    </button>
    <button class="orbit-dot" data-section="features" aria-label="Features section">
        <span class="orbit-label">Service</span>
    </button>
    <button class="orbit-dot" data-section="cta" aria-label="Booking section">
        <span class="orbit-label">Book</span>
    </button>
</nav>

<!-- ═══ NAVBAR ═══ -->
<jsp:include page="navbar.jsp"/>

<!-- ═══════════════════════════════════════════════════════════
     HERO — THE ZENITH ENTRANCE
     ═══════════════════════════════════════════════════════════ -->
<section class="hero" id="hero">
    <div class="hero-bg"></div>
    <div class="hero-overlay"></div>
    <div class="hero-mist"></div>

    <div class="hero-content">
        <img src="/images/logo-dark.png" class="brand-hero-logo theme-logo" alt="Roomie Logo">
        <div class="hero-badge">✦ Sri Lanka's Finest Rooms ✦</div>
        <h1 class="hero-title" data-magnetic>
            <span class="gold-text">Weightless</span> Luxury.
            <br>Elevated Living.
            <span class="thin-text">Where comfort meets the clouds</span>
        </h1>
        <p class="hero-subtitle">
            Rise above the ordinary. Discover curated hotel rooms floating between Sri Lanka's oceans, mountains, and skies.
        </p>
        <div class="hero-actions">
            <a href="/room/list" class="btn-gold" data-magnetic>Browse Rooms →</a>
            <c:if test="${empty sessionScope.loggedCustomer and empty sessionScope.loggedAdmin}">
                <a href="/customer/register" class="btn-outline-gold" data-magnetic>Sign Up Free</a>
            </c:if>
        </div>
    </div>

    <div class="scroll-cue">
        <span class="scroll-cue-text">Begin Ascent</span>
        <div class="scroll-cue-line"></div>
    </div>
</section>

<!-- ═══ CLOUD TRANSITION ═══ -->
<div class="cloud-transition"></div>

<!-- ═══════════════════════════════════════════════════════════
     SHOWCASE — THE ASCENT (SPLIT-SCREEN)
     ═══════════════════════════════════════════════════════════ -->
<section class="showcase" id="showcase">
    <div class="showcase-header reveal">
        <span class="showcase-tag">The Ascent</span>
        <h2 class="showcase-heading">
            Rooms that <span class="gold-text">breathe</span>.
            <br>Views that <span class="gold-text">soar</span>.
        </h2>
    </div>

    <div class="showcase-container">
        <!-- ═══ PINNED CANVAS (Left) ═══ -->
        <div class="showcase-left">
            <div class="showcase-img-stack">
                <div class="showcase-img-item active" data-index="0">
                    <img src="/images/showcase-coastal.png" alt="Coastal Suite overlooking the Indian Ocean" loading="lazy">
                    <div class="showcase-img-overlay coastal"></div>
                </div>
                <div class="showcase-img-item" data-index="1">
                    <img src="/images/showcase-hills.png" alt="Hill Country Villa among the clouds of Ella" loading="lazy">
                    <div class="showcase-img-overlay hills"></div>
                </div>
                <div class="showcase-img-item" data-index="2">
                    <img src="/images/showcase-jungle.png" alt="Jungle Retreat elevated above the canopy" loading="lazy">
                    <div class="showcase-img-overlay jungle"></div>
                </div>
            </div>
        </div>

        <!-- ═══ DRIFTING STORY (Right) ═══ -->
        <div class="showcase-right">
            <!-- Panel 1: Coastal -->
            <div class="showcase-panel" data-panel="0">
                <div class="showcase-panel-inner">
                    <div class="showcase-location">Coastal Suites</div>
                    <h3 class="showcase-title" data-magnetic>Floating Over the<br>Indian Ocean</h3>
                    <p class="showcase-tagline">"Where the horizon dissolves into your room."</p>
                    <p class="showcase-desc">
                        Wake to the rhythm of waves. Our Standard rooms capture the essence of Sri Lanka's pristine coastline
                        — endless ocean views, golden sunsets, and the gentle breeze of the Indian Ocean.
                    </p>
                    <div class="showcase-highlight">
                        <span class="showcase-highlight-icon">🏖️</span>
                        <div class="showcase-highlight-text">
                            <strong>Signature Experience</strong>
                            Private beach access with sunset lounge & complimentary evening cocktails
                        </div>
                    </div>
                    <ul class="showcase-features-list">
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🌅</span> Ocean-facing balcony</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🐚</span> Beachside dining</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🏊</span> Infinity pool access</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🧖</span> Sea-salt spa therapy</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">📶</span> High-speed WiFi</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">❄️</span> Climate-controlled AC</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🛏️</span> King-size bed</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🚿</span> Rainfall shower</li>
                    </ul>
                    <div class="showcase-price">
                        <span class="showcase-price-amount">LKR 5,000</span>
                        <span class="showcase-price-label">/ night</span>
                    </div>
                    <a href="/room/list" class="showcase-cta" data-magnetic>
                        Explore Coastal Rooms <span class="showcase-cta-arrow">→</span>
                    </a>
                </div>
            </div>

            <!-- Panel 2: Hill Country -->
            <div class="showcase-panel" data-panel="1">
                <div class="showcase-panel-inner">
                    <div class="showcase-location">Hill Country Villas</div>
                    <h3 class="showcase-title" data-magnetic>Living Among the<br>Clouds of Ella</h3>
                    <p class="showcase-tagline">"Altitude is an attitude."</p>
                    <p class="showcase-desc">
                        Perched among misty tea plantations and emerald peaks. Our Deluxe rooms offer panoramic mountain
                        views that make you feel like you're breathing above the world.
                    </p>
                    <div class="showcase-highlight">
                        <span class="showcase-highlight-icon">🍃</span>
                        <div class="showcase-highlight-text">
                            <strong>Signature Experience</strong>
                            Private tea-tasting veranda at dawn with freshly picked Ceylon leaves
                        </div>
                    </div>
                    <ul class="showcase-features-list">
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">⛰️</span> Mountain panorama</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🌿</span> Garden terrace</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🔥</span> Fireplace lounge</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">☕</span> Ceylon tea minibar</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">📺</span> Smart TV & Netflix</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🛁</span> Clawfoot soaking tub</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🌸</span> Aromatherapy kit</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🚶</span> Guided nature trails</li>
                    </ul>
                    <div class="showcase-price">
                        <span class="showcase-price-amount">LKR 8,000</span>
                        <span class="showcase-price-label">/ night</span>
                    </div>
                    <a href="/room/list" class="showcase-cta" data-magnetic>
                        Explore Hill Country <span class="showcase-cta-arrow">→</span>
                    </a>
                </div>
            </div>

            <!-- Panel 3: Jungle -->
            <div class="showcase-panel" data-panel="2">
                <div class="showcase-panel-inner">
                    <div class="showcase-location">Jungle Retreats</div>
                    <h3 class="showcase-title" data-magnetic>Elevated Above<br>the Canopy</h3>
                    <p class="showcase-tagline">"Luxury rises. Nature applauds."</p>
                    <p class="showcase-desc">
                        Our Suite rooms are sanctuaries suspended above the jungle. Private balconies, butler service,
                        and the symphony of wildlife below — this is weightless living at its finest.
                    </p>
                    <div class="showcase-highlight">
                        <span class="showcase-highlight-icon">🦜</span>
                        <div class="showcase-highlight-text">
                            <strong>Signature Experience</strong>
                            Private canopy walkway & exclusive sunrise safari with a personal guide
                        </div>
                    </div>
                    <ul class="showcase-features-list">
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🌴</span> Treetop balcony</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🍽️</span> Butler service 24/7</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🛀</span> Outdoor rain jacuzzi</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🦋</span> Wildlife wake-up calls</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🍷</span> Premium minibar</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🧘</span> Private yoga deck</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🌙</span> Stargazing terrace</li>
                        <li class="showcase-feature-item"><span class="showcase-feature-icon">🛎️</span> Personal concierge</li>
                    </ul>
                    <div class="showcase-price">
                        <span class="showcase-price-amount">LKR 15,000</span>
                        <span class="showcase-price-label">/ night</span>
                    </div>
                    <a href="/room/list" class="showcase-cta" data-magnetic>
                        Explore Jungle Suites <span class="showcase-cta-arrow">→</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ═══ CLOUD TRANSITION ═══ -->
<div class="cloud-transition"></div>

<!-- ═══════════════════════════════════════════════════════════
     ROOMS — DYNAMIC GRID
     ═══════════════════════════════════════════════════════════ -->
<section class="section section-dark" id="rooms">
    <div class="container">
        <div class="section-header reveal">
            <span class="section-tag">Our Accommodations</span>
            <h2 class="section-title">Handpicked Rooms for Every Traveller</h2>
            <p class="section-subtitle">Each room, a portal to weightlessness</p>
            <div class="section-divider"></div>
        </div>

        <c:choose>
            <c:when test="${empty featuredRooms}">
                <div style="text-align:center; color:var(--text-muted); padding:3rem;">
                    <p style="font-size:1.1rem;">No rooms available right now. Check back soon!</p>
                </div>
            </c:when>
            <c:otherwise>

                <!-- ── Coastal Collection (Standard) ── -->
                <div class="room-type-header reveal">
                    <span class="room-type-icon">🌊</span>
                    <div>
                        <h3 class="room-type-name">Coastal Collection</h3>
                        <p class="room-type-sub">Floating over the Indian Ocean</p>
                    </div>
                </div>
                <div class="rooms-grid">
                    <c:forEach var="room" items="${featuredRooms}">
                        <c:if test="${room.type == 'Standard'}">
                            <div class="room-card reveal" style="view-transition-name: room-card-${room.roomId};">
                                <div class="room-img-wrap" style="view-transition-name: room-image-${room.roomId};">
                                    <img src="/images/${room.imageFile}" alt="${room.displayType} Room ${room.roomNumber}" class="room-img" loading="lazy">
                                    <span class="room-type-badge">Coastal</span>
                                    <span class="room-status-badge ${room.status == 'OCCUPIED' ? 'occupied' : ''}">
                                        ${room.status == 'AVAILABLE' ? 'Available' : room.status}
                                    </span>
                                </div>
                                <div class="room-body">
                                    <div class="room-number">ROOM ${room.roomNumber}</div>
                                    <div class="room-name" data-magnetic>${room.displayType} Room</div>
                                    <div class="room-desc">${room.description} view — perfect for a relaxing stay.</div>
                                    <div class="room-amenities">
                                        <c:forEach var="a" items="${room.amenities}">
                                            <span class="amenity-tag">${a}</span>
                                        </c:forEach>
                                    </div>
                                    <div class="room-footer">
                                        <div>
                                            <div class="room-price">
                                                <span class="room-price-float"><strong>LKR ${room.pricePerNight}</strong></span>
                                                <span>/night</span>
                                            </div>
                                            <div class="room-capacity">👥 ${room.capacity} guests</div>
                                        </div>
                                        <a href="/room/detail/${room.roomId}" class="btn-view" data-magnetic>View Details</a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>

                <!-- ── Hill Country Collection (Deluxe) ── -->
                <div class="room-type-header reveal" style="margin-top: 4rem;">
                    <span class="room-type-icon">⛰️</span>
                    <div>
                        <h3 class="room-type-name">Hill Country Collection</h3>
                        <p class="room-type-sub">Living among the clouds of Ella</p>
                    </div>
                </div>
                <div class="rooms-grid">
                    <c:forEach var="room" items="${featuredRooms}">
                        <c:if test="${room.type == 'Deluxe'}">
                            <div class="room-card reveal" style="view-transition-name: room-card-${room.roomId};">
                                <div class="room-img-wrap" style="view-transition-name: room-image-${room.roomId};">
                                    <img src="/images/${room.imageFile}" alt="${room.displayType} Room ${room.roomNumber}" class="room-img" loading="lazy">
                                    <span class="room-type-badge">Hill Country</span>
                                    <span class="room-status-badge ${room.status == 'OCCUPIED' ? 'occupied' : ''}">
                                        ${room.status == 'AVAILABLE' ? 'Available' : room.status}
                                    </span>
                                </div>
                                <div class="room-body">
                                    <div class="room-number">ROOM ${room.roomNumber}</div>
                                    <div class="room-name" data-magnetic>${room.displayType} Room</div>
                                    <div class="room-desc">${room.description} view — perfect for a relaxing stay.</div>
                                    <div class="room-amenities">
                                        <c:forEach var="a" items="${room.amenities}">
                                            <span class="amenity-tag">${a}</span>
                                        </c:forEach>
                                    </div>
                                    <div class="room-footer">
                                        <div>
                                            <div class="room-price">
                                                <span class="room-price-float"><strong>LKR ${room.pricePerNight}</strong></span>
                                                <span>/night</span>
                                            </div>
                                            <div class="room-capacity">👥 ${room.capacity} guests</div>
                                        </div>
                                        <a href="/room/detail/${room.roomId}" class="btn-view" data-magnetic>View Details</a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>

                <!-- ── Jungle Collection (Suite) ── -->
                <div class="room-type-header reveal" style="margin-top: 4rem;">
                    <span class="room-type-icon">🌴</span>
                    <div>
                        <h3 class="room-type-name">Jungle Collection</h3>
                        <p class="room-type-sub">Elevated above the canopy</p>
                    </div>
                </div>
                <div class="rooms-grid">
                    <c:forEach var="room" items="${featuredRooms}">
                        <c:if test="${room.type == 'Suite'}">
                            <div class="room-card reveal" style="view-transition-name: room-card-${room.roomId};">
                                <div class="room-img-wrap" style="view-transition-name: room-image-${room.roomId};">
                                    <img src="/images/${room.imageFile}" alt="${room.displayType} Room ${room.roomNumber}" class="room-img" loading="lazy">
                                    <span class="room-type-badge">Jungle</span>
                                    <span class="room-status-badge ${room.status == 'OCCUPIED' ? 'occupied' : ''}">
                                        ${room.status == 'AVAILABLE' ? 'Available' : room.status}
                                    </span>
                                </div>
                                <div class="room-body">
                                    <div class="room-number">ROOM ${room.roomNumber}</div>
                                    <div class="room-name" data-magnetic>${room.displayType} Room</div>
                                    <div class="room-desc">${room.description} view — perfect for a relaxing stay.</div>
                                    <div class="room-amenities">
                                        <c:forEach var="a" items="${room.amenities}">
                                            <span class="amenity-tag">${a}</span>
                                        </c:forEach>
                                    </div>
                                    <div class="room-footer">
                                        <div>
                                            <div class="room-price">
                                                <span class="room-price-float"><strong>LKR ${room.pricePerNight}</strong></span>
                                                <span>/night</span>
                                            </div>
                                            <div class="room-capacity">👥 ${room.capacity} guests</div>
                                        </div>
                                        <a href="/room/detail/${room.roomId}" class="btn-view" data-magnetic>View Details</a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>

                <div style="text-align:center; margin-top:3rem;">
                    <a href="/room/list" class="btn-gold" data-magnetic>View All Rooms →</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- ═══ CLOUD TRANSITION ═══ -->
<div class="cloud-transition"></div>

<!-- ═══════════════════════════════════════════════════════════
     FEATURES — THE SERVICE
     ═══════════════════════════════════════════════════════════ -->
<section class="section" id="features">
    <div class="container">
        <div class="section-header reveal">
            <span class="section-tag">Why Roomie</span>
            <h2 class="section-title">Leave the World Beneath Your Feet</h2>
            <p class="section-subtitle">The Roomie difference, elevated</p>
            <div class="section-divider"></div>
        </div>
        <div class="features-grid">
            <div class="feature-card reveal">
                <span class="feature-icon">🌊</span>
                <div class="feature-title">Stunning Views</div>
                <div class="feature-desc">Choose from garden, pool, ocean, or panoramic views to match your mood and lifestyle.</div>
            </div>
            <div class="feature-card reveal">
                <span class="feature-icon">🔒</span>
                <div class="feature-title">Instant Booking</div>
                <div class="feature-desc">Real-time availability with zero double-booking. Your reservation is confirmed instantly.</div>
            </div>
            <div class="feature-card reveal">
                <span class="feature-icon">💎</span>
                <div class="feature-title">Premium Amenities</div>
                <div class="feature-desc">WiFi, AC, Smart TV, Mini Bars, Jacuzzis, Balconies and Butler Service in suites.</div>
            </div>
            <div class="feature-card reveal">
                <span class="feature-icon">💳</span>
                <div class="feature-title">Easy Payments</div>
                <div class="feature-desc">Flexible payment options — pay by card, bank transfer, or cash on arrival.</div>
            </div>
            <div class="feature-card reveal">
                <span class="feature-icon">⭐</span>
                <div class="feature-title">Verified Reviews</div>
                <div class="feature-desc">Every review comes from a real stay. Know exactly what you're getting before you book.</div>
            </div>
            <div class="feature-card reveal">
                <span class="feature-icon">🛎️</span>
                <div class="feature-title">24/7 Service</div>
                <div class="feature-desc">Round-the-clock staff ready to ensure your stay is nothing short of perfect.</div>
            </div>
        </div>
    </div>
</section>

<!-- ═══════════════════════════════════════════════════════════
     REVIEWS — GUEST STORIES
     ═══════════════════════════════════════════════════════════ -->
<section class="section section-dark" id="reviews">
    <div class="container">
        <div class="section-header reveal">
            <span class="section-tag">Guest Stories</span>
            <h2 class="section-title">What Our Guests Say</h2>
            <p class="section-subtitle">Voices from above</p>
            <div class="section-divider"></div>
        </div>
        <c:choose>
            <c:when test="${empty allReviews}">
                <div class="reviews-empty reveal">
                    <p style="font-size:1.1rem; margin-bottom:1rem;">✨ Be the first to share your experience!</p>
                    <a href="/review/add" class="btn-gold">Write a Review</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="reviews-grid">
                    <c:forEach var="review" items="${allReviews}" varStatus="loop">
                        <div class="review-card reveal">
                            <div class="review-stars">${review.stars}</div>
                            <div class="review-comment">"${review.comment}"</div>
                            <div class="review-author">
                                <div class="review-avatar">${review.customerName.charAt(0)}</div>
                                <div>
                                    <div class="review-name">${review.customerName}</div>
                                    <div class="review-date">${review.reviewDate}</div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- ═══ COUNTER ═══ -->
<div class="counter-section">
    <div class="counter-grid">
        <div class="counter-item">
            <span class="counter-num" data-count="${totalRooms}">0</span>
            <span class="counter-label">Rooms Available</span>
        </div>
        <div class="counter-item">
            <span class="counter-num" data-count="500">0</span>
            <span class="counter-label">Happy Guests</span>
        </div>
        <div class="counter-item">
            <span class="counter-num" data-count="3">0</span>
            <span class="counter-label">Room Categories</span>
        </div>
        <div class="counter-item">
            <span class="counter-num" data-count="${totalReviews}">0</span>
            <span class="counter-label">Guest Reviews</span>
        </div>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════════════
     CTA — THE SUMMIT
     ═══════════════════════════════════════════════════════════ -->
<section class="cta-section" id="cta">
    <div class="container">
        <div class="reveal">
            <span class="cta-badge">✦ The Summit ✦</span>
            <h2 class="cta-title" data-magnetic>
                Ready to <span class="gold-text">rise</span>?
                <br>Book your escape.
            </h2>
            <p class="cta-subtitle">Join hundreds of happy guests who've experienced weightless luxury. Your perfect stay in Sri Lanka awaits.</p>
            <div style="display:flex; gap:1rem; justify-content:center; flex-wrap:wrap; position:relative;">
                <a href="/room/list" class="btn-gold" data-magnetic>Browse All Rooms →</a>
                <c:if test="${empty sessionScope.loggedCustomer and empty sessionScope.loggedAdmin}">
                    <a href="/customer/register" class="btn-outline-gold" data-magnetic>Create Free Account</a>
                </c:if>
            </div>
        </div>
    </div>
</section>

<!-- ═══════════════════════════════════════════════════════════
     FOOTER — GROUND LEVEL
     ═══════════════════════════════════════════════════════════ -->
<footer class="footer">
    <div class="footer-grid">
        <div>
            <img src="/images/logo-dark.png" class="theme-logo" alt="Roomie Logo" style="height: 70px; margin-bottom: 0.8rem; object-fit: contain;">
            <div class="footer-desc">A premium hotel reservation system built with passion for comfort. SE1020 OOP Project — SLIIT, Group 4.</div>
        </div>
        <div>
            <div class="footer-heading">Explore</div>
            <ul class="footer-links">
                <li><a href="/room/list">All Rooms</a></li>
                <li><a href="/review/all">Guest Reviews</a></li>
                <li><a href="/customer/register">Sign Up</a></li>
            </ul>
        </div>
        <div>
            <div class="footer-heading">Account</div>
            <ul class="footer-links">
                <li><a href="/customer/login">Login</a></li>
                <li><a href="/reservation/my">My Bookings</a></li>
                <li><a href="/customer/profile">My Profile</a></li>
            </ul>
        </div>
        <div>
            <div class="footer-heading">Contact</div>
            <ul class="footer-links">
                <li><a href="#">contact@roomie.lk</a></li>
                <li><a href="#">+94 11 234 5678</a></li>
                <li><a href="#">Colombo, Sri Lanka</a></li>
            </ul>
        </div>
    </div>
    <div class="footer-bottom">
        <span class="footer-copy">&copy; 2026 Roomie. SE1020 OOP Project | SLIIT Group 4</span>
        <span class="footer-copy">Built with ❤️ in Sri Lanka</span>
    </div>
</footer>

<!-- ═══════════════════════════════════════════════════════════
     JAVASCRIPT
     ═══════════════════════════════════════════════════════════ -->
<script>
(function() {
    'use strict';

    var isTouch = ('ontouchstart' in window) || navigator.maxTouchPoints > 0;

    // ─── 2. MAGNETIC TEXT ────────────────────────────────────
    if (!isTouch) {
        document.querySelectorAll('[data-magnetic]').forEach(function(el) {
            el.addEventListener('mousemove', function(e) {
                var rect = el.getBoundingClientRect();
                var x = e.clientX - rect.left - rect.width / 2;
                var y = e.clientY - rect.top - rect.height / 2;
                var strength = el.tagName === 'H1' || el.tagName === 'H2' || el.tagName === 'H3' ? 0.05 : 0.15;
                el.style.transform = 'translate(' + (x * strength) + 'px, ' + (y * strength) + 'px)';
            });
            el.addEventListener('mouseleave', function() {
                el.style.transition = 'transform 0.5s cubic-bezier(0.23,1,0.32,1)';
                el.style.transform = 'translate(0, 0)';
                setTimeout(function() { el.style.transition = ''; }, 500);
            });
        });
    }

    // ─── 3. STARDUST CANVAS ─────────────────────────────────
    var canvas = document.getElementById('stardustCanvas');
    if (canvas) {
        var ctx = canvas.getContext('2d');
        var particles = [];
        var particleCount = 45;

        function resizeCanvas() {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
        }
        resizeCanvas();
        window.addEventListener('resize', resizeCanvas);

        for (var i = 0; i < particleCount; i++) {
            particles.push({
                x: Math.random() * canvas.width,
                y: Math.random() * canvas.height,
                size: Math.random() * 2 + 0.5,
                speedX: (Math.random() - 0.5) * 0.15,
                speedY: -(Math.random() * 0.25 + 0.05),
                opacity: Math.random() * 0.4 + 0.05,
                pulse: Math.random() * Math.PI * 2
            });
        }

        function isDark() {
            return document.documentElement.getAttribute('data-theme') !== 'light';
        }

        function drawStardust() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            var dark = isDark();
            for (var j = 0; j < particles.length; j++) {
                var p = particles[j];
                p.pulse += 0.01;
                var flicker = 0.5 + Math.sin(p.pulse) * 0.5;
                var alpha = p.opacity * flicker;

                ctx.beginPath();
                ctx.arc(p.x, p.y, p.size, 0, Math.PI * 2);
                if (dark) {
                    ctx.fillStyle = 'rgba(201, 168, 76, ' + alpha + ')';
                } else {
                    ctx.fillStyle = 'rgba(30, 58, 95, ' + (alpha * 0.5) + ')';
                }
                ctx.fill();

                // Glow for larger particles
                if (p.size > 1.5 && dark) {
                    ctx.beginPath();
                    ctx.arc(p.x, p.y, p.size * 3, 0, Math.PI * 2);
                    ctx.fillStyle = 'rgba(201, 168, 76, ' + (alpha * 0.08) + ')';
                    ctx.fill();
                }

                p.x += p.speedX;
                p.y += p.speedY;

                if (p.y < -10) {
                    p.y = canvas.height + 10;
                    p.x = Math.random() * canvas.width;
                }
                if (p.x < -10) p.x = canvas.width + 10;
                if (p.x > canvas.width + 10) p.x = -10;
            }
            requestAnimationFrame(drawStardust);
        }
        drawStardust();
    }

    // ─── 4. SHOWCASE IMAGE SWITCHING ────────────────────────
    var showcasePanels = document.querySelectorAll('.showcase-panel');
    var showcaseImages = document.querySelectorAll('.showcase-img-item');

    if (showcasePanels.length > 0 && showcaseImages.length > 0) {
        var panelObserver = new IntersectionObserver(function(entries) {
            entries.forEach(function(entry) {
                if (entry.isIntersecting) {
                    var idx = parseInt(entry.target.getAttribute('data-panel'));
                    // Activate corresponding image
                    showcaseImages.forEach(function(img, i) {
                        if (i === idx) {
                            img.classList.add('active');
                        } else {
                            img.classList.remove('active');
                        }
                    });
                    // Animate panel text
                    entry.target.classList.add('in-view');
                } else {
                    entry.target.classList.remove('in-view');
                }
            });
        }, { threshold: 0.4 });

        showcasePanels.forEach(function(p) { panelObserver.observe(p); });
    }

    // ─── 5. ORBITAL NAVIGATION ──────────────────────────────
    var orbitDots = document.querySelectorAll('.orbit-dot');
    var sectionIds = ['hero', 'showcase', 'rooms', 'features', 'cta'];

    // Click to scroll
    orbitDots.forEach(function(dot) {
        dot.addEventListener('click', function() {
            var targetId = dot.getAttribute('data-section');
            var targetEl = document.getElementById(targetId);
            if (targetEl) {
                targetEl.scrollIntoView({ behavior: 'smooth' });
            }
        });
    });

    // Active state on scroll
    var sectionObserver = new IntersectionObserver(function(entries) {
        entries.forEach(function(entry) {
            if (entry.isIntersecting) {
                var id = entry.target.id;
                orbitDots.forEach(function(dot) {
                    if (dot.getAttribute('data-section') === id) {
                        dot.classList.add('active');
                    } else {
                        dot.classList.remove('active');
                    }
                });
            }
        });
    }, { threshold: 0.25, rootMargin: '-10% 0px -10% 0px' });

    sectionIds.forEach(function(id) {
        var el = document.getElementById(id);
        if (el) sectionObserver.observe(el);
    });

    // ─── 6. SCROLL REVEAL ───────────────────────────────────
    var revealObserver = new IntersectionObserver(function(entries) {
        entries.forEach(function(e) {
            if (e.isIntersecting) {
                e.target.classList.add('visible');
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.reveal').forEach(function(el) {
        revealObserver.observe(el);
    });

    // Stagger room cards
    document.querySelectorAll('.room-card.reveal').forEach(function(card, index) {
        card.style.transitionDelay = (index * 0.12) + 's';
    });
    document.querySelectorAll('.feature-card.reveal').forEach(function(card, index) {
        card.style.transitionDelay = (index * 0.1) + 's';
    });
    document.querySelectorAll('.review-card.reveal').forEach(function(card, index) {
        card.style.transitionDelay = (index * 0.1) + 's';
    });

    // ─── 7. COUNTER ANIMATION ───────────────────────────────
    var counters = document.querySelectorAll('[data-count]');
    var counterObserver = new IntersectionObserver(function(entries) {
        entries.forEach(function(e) {
            if (!e.isIntersecting) return;
            var el = e.target;
            var target = parseInt(el.getAttribute('data-count')) || 0;
            if (target === 0) { el.textContent = '0'; return; }
            var start = 0;
            var step = Math.ceil(target / 60);
            var timer = setInterval(function() {
                start += step;
                if (start >= target) { start = target; clearInterval(timer); }
                el.textContent = start + (target >= 500 ? '+' : '');
            }, 30);
            counterObserver.unobserve(el);
        });
    }, { threshold: 0.5 });
    counters.forEach(function(c) { counterObserver.observe(c); });

    // ─── 8. NAVBAR SCROLL ───────────────────────────────────
    var nav = document.getElementById('mainNav');
    if (nav) {
        function onScroll() {
            if (window.scrollY > 50) {
                nav.classList.add('scrolled');
            } else {
                nav.classList.remove('scrolled');
            }
        }
        window.addEventListener('scroll', onScroll, { passive: true });
        onScroll();
    }

    // ─── 9. PARALLAX EFFECTS ────────────────────────────────
    var heroContent = document.querySelector('.hero-content');
    var heroMist = document.querySelector('.hero-mist');

    window.addEventListener('scroll', function() {
        var scrollY = window.scrollY;

        // Hero parallax
        if (heroContent && scrollY < window.innerHeight) {
            var progress = scrollY / window.innerHeight;
            heroContent.style.transform = 'translateY(' + (scrollY * 0.25) + 'px)';
            heroContent.style.opacity = 1 - progress * 1.2;
        }
        if (heroMist && scrollY < window.innerHeight) {
            heroMist.style.transform = 'translateY(' + (scrollY * -0.1) + 'px)';
        }

        // Showcase tagline parallax
        document.querySelectorAll('.showcase-tagline').forEach(function(el) {
            var rect = el.getBoundingClientRect();
            if (rect.top < window.innerHeight && rect.bottom > 0) {
                var offset = (rect.top - window.innerHeight / 2) * 0.06;
                el.style.transform = 'translateY(' + offset + 'px)';
            }
        });
    }, { passive: true });

})();
</script>
</body>
</html>