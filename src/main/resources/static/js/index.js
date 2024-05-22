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



// 分类展示电影的表单提交
function searchMovies(category) {
    const xhr = new XMLHttpRequest();
    xhr.open('POST', '/index/movieDetail', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            const movies = JSON.parse(xhr.responseText);
            const movieList = document.getElementById('movieList');
            movieList.innerHTML = '';
            movies.forEach(movie => {
                const movieElement = document.createElement('div');
                movieElement.textContent = movie.title;
                movieList.appendChild(movieElement);
            });
        }
    };
    xhr.send('category=' + encodeURIComponent(category));
}