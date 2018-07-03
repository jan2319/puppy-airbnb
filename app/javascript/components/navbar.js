function initUpdateNavbarOnScroll() {
  const navbar = document.querySelector('.navbar-wagon');
  const logo = document.querySelector('.navbar-wagon-brand');
  if (navbar) {
    window.addEventListener('scroll', () => {
            console.log(window.scrollY)

      if (window.scrollY >= window.innerHeight - 50) {
        navbar.classList.add('navbar-wagon-white');
        logo.classList.add('navbar-wagon-brand-dark');

      } else {
        navbar.classList.remove('navbar-wagon-white');
        logo.classList.remove('navbar-wagon-brand-dark');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };
