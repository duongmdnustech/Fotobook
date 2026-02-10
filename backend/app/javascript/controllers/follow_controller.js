import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="follow"
export default class extends Controller {
  connect() {
  }

  follow(event) {
    event.preventDefault();
    const userId = event.currentTarget.id.match(/\[([^\]]+)\]/)[1];

    fetch('/follow/' + userId, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        'Content-Type': 'application/json'
      }
    })
    .then(response => {
      if (response.ok) {
        // Update button state
        const button = document.getElementById(`follow-[${userId}]`);
        button.textContent = 'Following';
        button.classList.remove('btn-gradient-outline');
        button.classList.add('btn-gradient');
        button.id = `unfollow-[${userId}]`;
        button.setAttribute('data-action', 'follow#unfollow');
      } else {
        console.error('Failed to follow user');
      }
    });
  }

  unfollow(event) {
    event.preventDefault();
    const userId = event.currentTarget.id.match(/\[([^\]]+)\]/)[1];

    fetch('/unfollow/' + userId, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        'Content-Type': 'application/json'
      }
    })
    .then(response => {
      if (response.ok) {
        // Update button state
        const button = document.getElementById(`unfollow-[${userId}]`);
        button.textContent = 'Follow';
        button.classList.remove('btn-gradient');
        button.classList.add('btn-gradient-outline');
        button.id = `follow-[${userId}]`;
        button.setAttribute('data-action', 'follow#follow');
      } else {
        console.error('Failed to unfollow user');
      }
    }
    );
  }
}
