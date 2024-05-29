function searchHistory() {
    // 发送与接收请求
    const xhr = new XMLHttpRequest();
    xhr.open('POST', '/history/movieList', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onload = function () {
        if (xhr.status === 200) {
            var response = JSON.parse(xhr.responseText);
            var movieList = response.movieList;
            var userPlaybackHistoryList = response.userPlaybackHistoryList;
            console.log(movieList);

            var resultsList = document.querySelector('.movie-list ul');
            resultsList.innerHTML = '';
            // 绘制前端页面
            for (let i = 0; i < movieList.length; i++) {
                // 获取这一行的电影和其观看时间
                let movie = movieList[i];
                let viewingTimestamp = userPlaybackHistoryList[i].viewingTimestamp;

                // 每部电影一个li
                const li = document.createElement('li');
                li.classList.add('movie-item');

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

                // 电影信息——观看时间
                const viewTime = document.createElement('p');
                viewTime.classList.add("movie-view-time");
                // 处理时间戳字符串
                var formattedTimestamp = viewingTimestamp.replace("T", " ");
                viewTime.textContent = "在 " + formattedTimestamp + " 时观看";

                // 电影数据（作为一个定位用的div）
                const data = document.createElement('div');
                data.classList.add('movie-data');
                // 提示信息
                const tip = document.createElement('p');
                tip.textContent = "继续观看";

                // 添加点击事件监听器
                data.addEventListener('click', function () {
                    window.location.href = '/moviePlay?movieId=' + movie.movieId;
                });

                info.appendChild(title);
                info.appendChild(viewTime);
                data.appendChild(tip);
                li.appendChild(img);
                li.appendChild(info);
                li.appendChild(data)
                resultsList.appendChild(li);
            }
        } else {
            console.error('Error:', xhr.statusText);
        }
    };
    xhr.send();
}

// 打开页面时进入热播排行
window.onload = function () {
    searchHistory();
}