// 图片轮播
const slides = document.querySelectorAll('.slide');
const prevArrow = document.querySelector('.prev-arrow');
const nextArrow = document.querySelector('.next-arrow');
let currentSlide = 0;

function showSlide(n) {
    slides[currentSlide].classList.remove('active');
    currentSlide = (n + slides.length) % slides.length;
    slides[currentSlide].classList.add('active');
}

document.addEventListener("DOMContentLoaded", function (){
    slides[currentSlide].classList.add('active');
});

function nextSlide() {
    showSlide(currentSlide + 1);
}

function prevSlide() {
    showSlide(currentSlide - 1);
}

prevArrow.addEventListener('click', prevSlide);
nextArrow.addEventListener('click', nextSlide);

let slideInterval = setInterval(nextSlide, 1500);

slides.forEach(slide => {
    slide.addEventListener('mouseover', () => {
        clearInterval(slideInterval);
    });

    slide.addEventListener('mouseout', () => {
        slideInterval = setInterval(nextSlide, 3000);
    });
});

// 分类展示电影提交
function searchMovies(category) {
    const xhr = new XMLHttpRequest();
    xhr.open('POST', '/index/movieList', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onload = function() {
        location.reload();
    };
    xhr.send('category=' + encodeURIComponent(category));
}