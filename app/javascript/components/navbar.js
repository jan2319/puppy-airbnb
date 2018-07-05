function initUpdateNavbarOnScroll() {
  const navbar = document.querySelector('.navbar-wagon');
  const logo = document.querySelector('.navbar-wagon-brand-dark');
  const hamburger = document.querySelector('.hamburger')
  if (top.location.pathname === '/') {
    if (navbar) {
      navbar.classList.add('navbar-wagon-home');
      logo.classList.add('navbar-wagon-brand');
      hamburger.classList.add('white-t-clear-bg');

      window.addEventListener('scroll', () => {
              console.log(window.scrollY)

        if (window.scrollY >= window.innerHeight - 50) {
          navbar.classList.remove('navbar-wagon-home');
          logo.classList.remove('navbar-wagon-brand');
          hamburger.classList.remove('white-t-clear-bg');

        } else {
          navbar.classList.add('navbar-wagon-home');
          logo.classList.add('navbar-wagon-brand');
          hamburger.classList.add('white-t-clear-bg');
        }
      });
    }
  }
}

export { initUpdateNavbarOnScroll };
