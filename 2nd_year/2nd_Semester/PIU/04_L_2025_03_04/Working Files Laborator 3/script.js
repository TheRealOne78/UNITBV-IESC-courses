document.getElementById('rating').addEventListener('input', function() {
    document.getElementById('ratingOutput').textContent = this.value;
});

document.getElementById('feedbackForm').addEventListener('submit', function(event) {
    event.preventDefault();
    alert('Feedback trimis! Mulțumim.');
});
