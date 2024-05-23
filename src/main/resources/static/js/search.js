function search(content) {
    var query = document.querySelector('.search-input').value;
    if (content != null) query = content; //此函数默认选择搜索栏的字符串为查询参数

    if (query) {
        // 发送搜索请求到后端
        const xhr = new XMLHttpRequest();
        xhr.open('POST', '/search/movieList', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function () {
            if (xhr.status === 200) {
                document.querySelector('.trending').classList.add('hidden');
                var searchBar = document.querySelector('.search-bar');
                var logoLink = document.querySelector('.logo-link');
                searchBar.classList.add('top-bar');
                searchBar.insertBefore(logoLink, searchBar.firstChild); // 将logoLink插入到searchBar的最前面
                document.querySelector('.results-container').classList.remove('hidden');

                // 处理 JSON 响应
                var movieList = JSON.parse(xhr.responseText);
                console.log(movieList);
                var resultsList = document.querySelector('.results-container ul');
                resultsList.innerHTML = '';

                movieList.forEach(function (movie) {
                    var li = document.createElement('li');
                    li.classList.add('movie-item');
                    var img = document.createElement('img');
                    img.src = "/cover/"
                    img.src += movie.movieCoverUrl; // 使用 movieCoverUrl 属性
                    img.alt = movie.movieTitle; // 使用 movieTitle 属性
                    var name = document.createElement('div');
                    name.classList.add('name');
                    name.textContent = movie.movieTitle; // 使用 movieTitle 属性
                    li.appendChild(img);
                    li.appendChild(name);
                    resultsList.appendChild(li);
                });
            } else {
                console.error('Error:', xhr.statusText); // 错误处理
            }
        };
        xhr.send('query=' + encodeURIComponent(query)); // 编码后发送请求参数
    }
}

document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('.results-container').classList.add('hidden');
    var searchInput = document.querySelector('.search-input');
    var searchButton = document.querySelector('.search-button');

    // 点击搜索按钮时进行搜索
    searchButton.addEventListener('click', function () {
        search();
    });

    // 按下回车键时进行搜索
    searchInput.addEventListener('keypress', function(event) {
        if (event.key === 'Enter') {
            search();
        }
    });

    // 点击热搜条目时进行搜索
    var trendingItems = document.querySelectorAll('.trending li');
    trendingItems.forEach(function(item) {
        item.addEventListener('click', function() {
            var query = item.textContent.trim().slice(2);
            document.querySelector('.search-input').value = query;
            search(query);
        });
    });
});