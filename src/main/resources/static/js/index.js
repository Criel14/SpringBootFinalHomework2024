// 分页查询所用变量
var currentPage = 0;
var pageSize = 4;
var total = 0;
// 分页查询的查询依据
var nowQuery = ""

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

document.addEventListener("DOMContentLoaded", function () {
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
function fetchMovies(query, page) {
    const xhr = new XMLHttpRequest();
    xhr.open('POST', '/index/movieList', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onload = function () {
        if (xhr.status === 200) {
            var response = JSON.parse(xhr.responseText);
            var movieList = response.movies;
            total = response.total;
            console.log(movieList);
            console.log(total);
            console.log(currentPage);
            var resultsList = document.querySelector('.movie-list ul');
            resultsList.innerHTML = '';
            // 绘制前端页面
            movieList.forEach(function (movie) {
                var li = document.createElement('li');
                li.classList.add('movie-item');

                var img = document.createElement('img');
                img.src = '/cover/' + movie.movieCoverUrl;
                img.alt = movie.movieTitle;

                var name = document.createElement('div');
                name.classList.add('movie-title');
                name.textContent = movie.movieTitle;

                li.appendChild(img);
                li.appendChild(name);
                resultsList.appendChild(li);
            });

            // 更新当前页显示
            document.querySelector('.current-page').textContent = page + 1;
            document.querySelector('.total-pages').textContent = total;
        } else {
            console.error('Error:', xhr.statusText);
        }
    };
    xhr.send('query=' + encodeURIComponent(query) + '&page=' + page + '&size=' + pageSize);
}

// 点击分类按钮进入此方法
function searchMovies(query) {
    nowQuery = query;
    // 进入新的分类，则重置当前页码
    currentPage = 0;
    fetchMovies(query, currentPage);
}

document.querySelector('.prev-page').addEventListener('click', function () {
    if (currentPage > 0) {
        currentPage--;
        fetchMovies(nowQuery, currentPage);
    }
});

document.querySelector('.next-page').addEventListener('click', function () {
    if (currentPage < total - 1) {
        currentPage++;
        fetchMovies(nowQuery, currentPage);
    }
});

window.onload = function () {
    fetchMovies(nowQuery, currentPage);
}
