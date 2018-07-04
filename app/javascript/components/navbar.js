function initUpdateNavbarOnScroll() {
  const navbar = document.querySelector('.navbar-wagon');
  const logo = document.querySelector('.navbar-wagon-brand-dark');
  if (top.location.pathname === '/') {
    if (navbar) {
      navbar.classList.add('navbar-wagon-home');
      logo.classList.add('navbar-wagon-brand');

      window.addEventListener('scroll', () => {
              console.log(window.scrollY)

        if (window.scrollY >= window.innerHeight - 50) {
          navbar.classList.remove('navbar-wagon-home');
          logo.classList.remove('navbar-wagon-brand');

        } else {
          navbar.classList.add('navbar-wagon-home');
          logo.classList.add('navbar-wagon-brand');
        }
      });
    }
  }
}

export { initUpdateNavbarOnScroll };
