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
                const li = document.createElement('li');
                li.classList.add('movie-item');

                // 添加点击事件监听器
                li.addEventListener('click', function () {
                    window.location.href = '/moviePlay?movieId=' + movie.movieId;
                });

                const img = document.createElement('img');
                img.src = '/cover/' + movie.movieCoverUrl;
                img.alt = movie.movieTitle;

                const info = document.createElement('div');
                info.classList.add('movie-info');

                const title = document.createElement('p');
                title.classList.add('movie-title');
                title.textContent = movie.movieTitle;

                const tips = ["超10万条弹幕", "霸榜10天", "昨日上新"];
                const tip = document.createElement('p');
                tip.classList.add('movie-tip');
                tip.textContent = tips[Math.floor(Math.random() * tips.length)];

                const date = document.createElement('p');
                date.classList.add('movie-date');
                date.textContent = movie.releaseDate.split('T')[0];

                const description = document.createElement('p');
                description.classList.add('movie-description');
                description.textContent = movie.movieDescription.substring(0, 200);
                if (description.textContent.length >= 200) {
                    description.textContent += '...';
                }

                info.appendChild(title);
                info.appendChild(tip);
                info.appendChild(date);
                info.appendChild(description);
                li.appendChild(img);
                li.appendChild(info);
                resultsList.appendChild(li);
            });
        } else {
            console.error('Error:', xhr.statusText);
        }
    };
    xhr.send('query=' + encodeURIComponent(query));
}

// 设置默认选中样式
document.getElementById('play').classList.add('selected');

// 打开页面时进入热播排行
window.onload = function () {
    searchRank('play');
}
