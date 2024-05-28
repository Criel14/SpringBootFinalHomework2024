document.addEventListener('DOMContentLoaded', function() {
    var searchInput = document.querySelector('.search-input');
    var searchButton = document.querySelector('.search-button');
    var currentPage = 0;
    var pageSize = 5;
    var total = 0;

    function fetchMovies(query, page) {
        const xhr = new XMLHttpRequest();
        xhr.open('POST', '/search/movieList', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function () {
            if (xhr.status === 200) {
                var response = JSON.parse(xhr.responseText);
                var movieList = response.movies;
                total = response.total;
                console.log(movieList);
                console.log(total);
                console.log(currentPage);
                var resultsList = document.querySelector('.results-container ul');
                resultsList.innerHTML = '';

                if (movieList.length === 0) {
                    document.querySelector('.results-container').classList.add('hidden');
                    document.querySelector('.pagination').classList.add('hidden');
                    document.querySelector('.no-results').classList.remove('hidden');
                } else {
                    document.querySelector('.no-results').classList.add('hidden');
                    document.querySelector('.results-container').classList.remove('hidden');
                    document.querySelector('.pagination').classList.remove('hidden');
                    movieList.forEach(function (movie) {
                        var li = document.createElement('li');
                        li.classList.add('movie-item');

                        var img = document.createElement('img');
                        img.src = '/cover/' + movie.movieCoverUrl;
                        img.alt = movie.movieTitle;

                        var name = document.createElement('div');
                        name.classList.add('name');
                        name.textContent = movie.movieTitle;
                        // 添加点击事件监听器
                        li.addEventListener('click', function() {
                            window.location.href = '/moviePlay?movieId=' + movie.movieId;
                        });
                        li.appendChild(img);
                        li.appendChild(name);
                        resultsList.appendChild(li);
                    });

                    // 更新当前页显示
                    document.querySelector('.current-page').textContent = page + 1;
                    document.querySelector('.total-pages').textContent = total;
                }
            } else {
                console.error('Error:', xhr.statusText);
            }
        };
        xhr.send('query=' + encodeURIComponent(query) + '&page=' + page + '&size=' + pageSize);
    }

    function search() {
        var query = searchInput.value;
        if (query) {
            document.querySelector('.trending').classList.add('hidden');
            var searchBar = document.querySelector('.search-bar');
            var logoLink = document.querySelector('.logo-link');
            searchBar.classList.add('top-bar');
            searchBar.insertBefore(logoLink, searchBar.firstChild);

            // 重置当前页为0
            currentPage = 0;
            fetchMovies(query, currentPage);
        }
    }

    searchButton.addEventListener('click', search);
    searchInput.addEventListener('keypress', function(event) {
        if (event.key === 'Enter') {
            search();
        }
    });

    var trendingItems = document.querySelectorAll('.trending li');
    trendingItems.forEach(function(item) {
        item.addEventListener('click', function() {
            var query = item.textContent.trim().slice(2);
            searchInput.value = query;
            search();
        });
    });

    document.querySelector('.prev-page').addEventListener('click', function() {
        if (currentPage > 0) {
            currentPage--;
            fetchMovies(searchInput.value, currentPage);
        }
    });

    document.querySelector('.next-page').addEventListener('click', function() {
        if (currentPage < total - 1) {
            currentPage++;
            fetchMovies(searchInput.value, currentPage);
        }
    });
});
