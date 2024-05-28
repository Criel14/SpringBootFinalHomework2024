// 分页查询所用变量
var currentPage = 0;
var pageSize = 5;
var total = 0;
// 分页查询的查询依据
var nowQuery = "";
// 当前登录用户
var currentUser = null;

// 分类展示电影提交，query是分类依据
// 主要是路径不一样，其他的都和index一样
function fetchMovies(query, page) {
    const xhr = new XMLHttpRequest();
    xhr.open('POST', '/vipMovie/movieList', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onload = function () {
        if (xhr.status === 200) {
            var response = JSON.parse(xhr.responseText);
            var movieList = response.movies;
            // 赋值给currentUser，因为加载页面的时候就会调用本函数，所以可以写在这里
            currentUser = response.resUser;
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

                // 添加点击事件监听器
                li.addEventListener('click', function() {
                    window.location.href = '/moviePlay?movieId=' + movie.movieId;
                });
                // 电影封面
                var img = document.createElement('img');
                img.src = '/cover/' + movie.movieCoverUrl;
                img.alt = movie.movieTitle;
                // 电影标题
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
function searchVipMovies(query) {
    // 去除所有rank-item的selected样式
    document.querySelectorAll('.classify-item').forEach(item => {
        item.classList.remove('selected');
    });
    // 为点击的设置选中样式
    if (query) {
        document.getElementById(query).classList.add('selected');
    }

    nowQuery = query;
    // 进入新的分类，则重置当前页码
    currentPage = 0;
    fetchMovies(query, currentPage);
}

// 设置默认选中样式
document.getElementById('all').classList.add('selected');

// 翻页
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

// 页面加载时查找所有
window.onload = function () {
    // 首次加载时查找全部
    fetchMovies("all", currentPage);
    fetch('/isVip')
        .then(response => response.json())
        .then(data => {
            var isVip;
            isVip = data;
            if (!isVip) {
                openOverlay();
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
}

// 打开覆盖层
function openOverlay() {
    document.getElementById('overlay').style.display = 'flex';
}

// 关闭覆盖层
function closeOverlay() {
    document.getElementById('overlay').style.display = 'none';
}

// 进入会员中心
function toVipPage() {
    window.location.href = '/vip';
}
