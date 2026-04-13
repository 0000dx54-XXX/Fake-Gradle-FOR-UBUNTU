// JavaScript для Recent OS V0.1 сайта

document.addEventListener('DOMContentLoaded', function() {
    // Плавная прокрутка для навигации
    document.querySelectorAll('nav a').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            const targetSection = document.querySelector(targetId);
            
            window.scrollTo({
                top: targetSection.offsetTop - 70,
                behavior: 'smooth'
            });
        });
    });

    // Анимация появления элементов при прокрутке
    const features = document.querySelectorAll('.feature, .tech, .features-list li');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = 1;
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, { threshold: 0.1 });

    features.forEach(feature => {
        feature.style.opacity = 0;
        feature.style.transform = 'translateY(20px)';
        feature.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
        observer.observe(feature);
    });

    // Эффект при наведении на кнопку скачивания
    const downloadBtn = document.querySelector('.download-btn');
    if (downloadBtn) {
        downloadBtn.addEventListener('mouseover', function() {
            this.style.transform = 'translateY(-3px) scale(1.05)';
        });
        
        downloadBtn.addEventListener('mouseout', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    }
});