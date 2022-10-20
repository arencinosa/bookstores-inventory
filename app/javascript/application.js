// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

window.stock_level_url = function () {
    let bookstore_el = document.getElementById('bookstore_name');
    let book_el = document.getElementById('book_name');
    let url = document.getElementById('stock_level_url').value;
    url = url.replace('bookstore_id', bookstore_el.value);
    url = url.replace('book_id', book_el.value);

    return url;
};

window.validateOperationSections = function () {
    let bookstore_el = document.getElementById('bookstore_name');
    let book_el = document.getElementById('book_name');
    let both_present = bookstore_el.value && book_el.value;
    let stock_level_el = document.getElementById('stock_level');
    let url = window.stock_level_url();
    if (both_present) {
        fetch(url)
            .then(function (response) {
                if (response.ok) {
                    return response.text();
                } else {
                    console.log('ERROR -> PUT', url, { progress: progress }, response);
                }
            })
            .then(function (value) {
                stock_level_el.value = value;
                stock_level_el.classList.remove('hide');
            });
    } else {
        stock_level_el.classList.add('hide');
    }
};

window.updateStockLevel = function (stock_level) {
    let url = window.stock_level_url();

    fetch(url, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ stock_level: stock_level })
    }).then(function (response) {
        if (!response.ok) {
            console.log('ERROR -> PUT', url, { stock_level: stock_level }, response);
        }
    });
}