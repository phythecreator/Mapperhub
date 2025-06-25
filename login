<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Login - MapCraft</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />
</head>
<body class="bg-gray-900 text-white flex items-center justify-center min-h-screen">
  <div class="bg-gray-800 p-8 rounded max-w-md w-full">
    <h1 class="text-2xl font-bold mb-6 text-center">Login / Create Account</h1>
    <form id="loginForm" class="flex flex-col gap-4" novalidate>
      <input type="email" id="emailInput" placeholder="Email" required
        class="p-3 rounded text-black w-full" />
      <input type="password" id="passwordInput" placeholder="Password" minlength="6" required
        class="p-3 rounded text-black w-full" />
      <input type="password" id="confirmPasswordInput" placeholder="Confirm Password" minlength="6" required
        class="p-3 rounded text-black w-full hidden" />
      <button type="submit" class="bg-blue-600 py-3 rounded hover:bg-blue-700 font-semibold">Login</button>
    </form>
    <p class="mt-4 text-sm text-gray-400 text-center" id="toggleText">
      Don't have an account? <button id="toggleBtn" class="text-blue-400 underline">Sign up</button>
    </p>
    <div id="errorMsg" class="text-red-500 text-sm mt-2 text-center"></div>
  </div>

  <script>
    const form = document.getElementById("loginForm");
    const toggleBtn = document.getElementById("toggleBtn");
    const toggleText = document.getElementById("toggleText");
    const errorMsg = document.getElementById("errorMsg");
    const confirmPasswordInput = document.getElementById("confirmPasswordInput");
    let isLogin = true;

    toggleBtn.addEventListener("click", () => {
      isLogin = !isLogin;
      errorMsg.textContent = "";
      if (isLogin) {
        confirmPasswordInput.classList.add("hidden");
        form.querySelector("button").textContent = "Login";
        toggleText.innerHTML = `Don't have an account? <button id="toggleBtn" class="text-blue-400 underline">Sign up</button>`;
      } else {
        confirmPasswordInput.classList.remove("hidden");
        form.querySelector("button").textContent = "Sign up";
        toggleText.innerHTML = `Already have an account? <button id="toggleBtn" class="text-blue-400 underline">Login</button>`;
      }
      // Rebind event after innerHTML change
      document.getElementById("toggleBtn").addEventListener("click", () => {
        toggleBtn.click();
      });
    });

    function validateEmail(email) {
      return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    }

    form.addEventListener("submit", e => {
      e.preventDefault();
      errorMsg.textContent = "";

      const email = document.getElementById("emailInput").value.trim().toLowerCase();
      const password = document.getElementById("passwordInput").value;
      const confirm = confirmPasswordInput.value;

      if (!validateEmail(email)) {
        errorMsg.textContent = "Please enter a valid email.";
        return;
      }
      if (password.length < 6) {
        errorMsg.textContent = "Password must be at least 6 characters.";
        return;
      }
      if (!isLogin && password !== confirm) {
        errorMsg.textContent = "Passwords do not match.";
        return;
      }

      let users = JSON.parse(localStorage.getItem("users") || "[]");

      if (isLogin) {
        const user = users.find(u => u.email === email && u.password === password);
        if (user) {
          localStorage.setItem("userEmail", email);
          alert(`Welcome back, ${email}!`);
          window.location.href = "index.html";
        } else {
          errorMsg.textContent = "Invalid email or password.";
        }
      } else {
        if (users.some(u => u.email === email)) {
          errorMsg.textContent = "Email already registered.";
          return;
        }
        users.push({ email, password });
        localStorage.setItem("users", JSON.stringify(users));
        alert("Account created! Please log in.");
        toggleBtn.click();
        form.reset();
      }
    });
  </script>
</body>
</html>




