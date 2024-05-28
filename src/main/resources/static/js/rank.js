// query是排序依据
function searchRank(query) {
    // 去除所有rank-item的selected样式
    document.querySelectorAll('.rank-item').forEach(item => {
        item.classList.remove('selected');
    });
    // 为点击的设置选中样式
    if (query) {
        document.getElementById(query).classList.add('selected');
    }

    // 发送与接收请求
    const xhr = new XMLHttpRequest();
    xhr.open('POST', '/rank/movieList', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onload = function () {
        if (xhr.status === 200) {
            var movieList = JSON.parse(xhr.responseText);
            console.log(movieList);
            var resultsList = document.querySelector('.movie-list ul');
            resultsList.innerHTML = '';
            // 绘制前端页面
            movieList.forEach(function (movie) {
                // 每部电影一个li
                const li = document.createElement('li');
                li.classList.add('movie-item');

                // 添加点击事件监听器
                li.addEventListener('click', function () {
                    window.location.href = '/moviePlay?movieId=' + movie.movieId;
                });

                // 电影封面
                const img = document.createElement('img');
                img.src = '/cover/' + movie.movieCoverUrl;
                img.alt = movie.movieTitle;

                // 电影信息
                const info = document.createElement('div');
                info.classList.add('movie-info');

                // 电影信息——电影标题
                const title = document.createElement('p');
                title.classList.add('movie-title');
                title.textContent = movie.movieTitle;

                // 电影信息——热度提醒
                const tips = ["超10万条弹幕", "霸榜10天", "昨日上新"];
                const tip = document.createElement('p');
                tip.classList.add('movie-tip');
                tip.textContent = tips[Math.floor(Math.random() * tips.length)];

                // 电影信息——上映日期
                const date = document.createElement('p');
                date.classList.add('movie-date');
                date.textContent = movie.releaseDate.split('T')[0];

                // 电影信息——电影描述
                const description = document.createElement('p');
                description.classList.add('movie-description');
                description.textContent = movie.movieDescription.substring(0, 200);
                if (description.textContent.length >= 200) {
                    description.textContent += '...';
                }

                // 电影数据（热度、评分之类）
                const data = document.createElement('div');
                data.classList.add('movie-data');
                // 数据与数据的解释
                const mainData = document.createElement('p');
                const explain = document.createElement('span');
                // 按不同榜单
                if (query === "score") {
                    explain.textContent = "电影评分";
                    mainData.textContent = "★ " + parseFloat(movie.movieScore).toFixed(1);
                } else if (query === "all") {
                    explain.textContent = "电影评分";
                    mainData.textContent = "👍" + parseFloat(movie.movieScore).toFixed(1);
                } else if (query === "playCount") {
                    explain.textContent = "今日热度";
                    mainData.textContent = "🔥" + Math.floor(movie.totalPlays * movie.movieScore / 100);
                } else {
                    explain.textContent = "播放总量";
                    mainData.textContent = "▶" + movie.totalPlays;
                }

                data.appendChild(mainData);
                data.appendChild(explain);
                info.appendChild(title);
                info.appendChild(tip);
                info.appendChild(date);
                info.appendChild(description);
                li.appendChild(img);
                li.appendChild(info);
                li.appendChild(data)
                resultsList.appendChild(li);
            });
        } else {
            console.error('Error:', xhr.statusText);
        }
    };
    xhr.send('query=' + encodeURIComponent(query));
}

// 设置默认选中样式
document.getElementById('playCount').classList.add('selected');

// 打开页面时进入热播排行
window.onload = function () {
    searchRank('playCount');
}