// in production this should be the real backend URL or an env variable
const API_URL = '/api';
async function getMessage() {
  const btn = document.getElementById('getMessageBtn');
  const resultDiv = document.getElementById('result');
  const errorDiv = document.getElementById('error');
  const messageText = document.getElementById('messageText');

  // reset previous state
  resultDiv.classList.add('hidden');
  errorDiv.classList.add('hidden');
  btn.disabled = true;
  btn.textContent = 'Loading...';

  try {
    const response = await fetch(`${API_URL}/message`);
    if (!response.ok) {
      throw new Error('Server returned an error');
    }

    const data = await response.json();

    messageText.textContent = data.message;
    resultDiv.classList.remove('hidden');

  } catch (err) {
    console.error('Error fetching message:', err);
    errorDiv.classList.remove('hidden');
  } finally {
    btn.disabled = false;
    btn.textContent = 'Get Message';
  }
}
