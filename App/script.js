let slideNum = 1;
slide(slideNum);

function nextprevBtn(n) {
    slide(slideNum += n);
}

function currSlide(n) {
    slide(slideNum = n);
}

function slide(n) {
    let i;
    let slides = document.getElementsByClassName("slider");
    let dots = document.getElementsByClassName("dot");
    
    if (n > slides.length) {
        slideNum = 1
    }
    if (n < 1) {
        slideNum = slides.length
    }

    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
    }

    slides[slideNum-1].style.display = "block";
    dots[slideNum-1].className += " active";
}