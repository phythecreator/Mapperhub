<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Login | MapCraft</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />
</head>
<body class="bg-gray-900 text-white flex items-center justify-center min-h-screen">
  <div class="bg-gray-800 p-8 rounded shadow-lg w-full max-w-md">
    <h2 id="formTitle" class="text-2xl font-bold mb-6 text-center">Login to MapCraft</h2>

    <form id="authForm" class="flex flex-col gap-4">
      <input
        type="email"
        id="email"
        placeholder="Email"
        class="p-3 rounded bg-gray-700 text-white"
        required
      />
      <input
        type="password"
        id="password"
        placeholder="Password"
        class="p-3 rounded bg-gray-700 text-white"
        required
      />
      <button
        type="submit"
        class="bg-blue-600 py-2 rounded hover:bg-blue-700"
      >
        Login
      </button>
    </form>

    <p class="mt-4 text-sm text-gray-400 text-center" id="toggleText">
      Don't have an account? <button id="toggleBtn" class="text-blue-400 underline">Sign up</button>
    </p>
  </div>

  <script>
    const authForm = document.getElementById("authForm");
    const toggleBtn = document.getElementById("toggleBtn");
    const toggleText = document.getElementById("toggleText");
    const formTitle = document.getElementById("formTitle");

    let isLogin = true;

    // Toggle between login and register form
    toggleBtn.addEventListener("click", () => {
      isLogin = !isLogin;
      if (isLogin) {
        formTitle.textContent = "Login to MapCraft";
        authForm.querySelector("button").textContent = "Login";
        toggleText.innerHTML = `Don't have an account? <button id="toggleBtn" class="text-blue-400 underline">Sign up</button>`;
      } else {
        formTitle.textContent = "Create a new account";
        authForm.querySelector("button").textContent = "Sign Up";
        toggleText.innerHTML = `Already have an account? <button id="toggleBtn" class="text-blue-400 underline">Login</button>`;
      }
      // Re-attach event listener for the new button (because innerHTML replaces it)
      document.getElementById("toggleBtn").addEventListener("click", () => {
        toggleBtn.click();
      });
    });

    authForm.addEventListener("submit", e => {
      e.preventDefault();
      const email = document.getElementById("email").value.toLowerCase();
      const password = document.getElementById("password").value;

      // Get users from localStorage or empty array
      const users = JSON.parse(localStorage.getItem("users") || "[]");

      if (isLogin) {
        // Login flow
        const user = users.find(u => u.email === email && u.password === password);
        if (user) {
          localStorage.setItem("userEmail", email);
          localStorage.setItem("lastLogin", new Date().toISOString());
          alert(`Welcome back, ${email}!`);
          window.location.href = "index.html";
        } else {
          alert("Invalid email or password.");
        }
      } else {
        // Register flow
        if (users.some(u => u.email === email)) {
          alert("Email already registered.");
          return;
        }
        users.push({ email, password });
        localStorage.setItem("users", JSON.stringify(users));
        alert("Account created! Please login.");
        toggleBtn.click(); // Switch to login form
        authForm.reset();
      }
    });
  </script>
</body>
</html>
