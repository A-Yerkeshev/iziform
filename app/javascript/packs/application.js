// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks"
// import * as ActiveStorage from "@rails/activestorage"
// import "channels"

// //= require jquery3
// //= require popper
// //= require bootstrap-sprockets
// //= require owl.carousel.min
// //= require owl_carousel_setup

// Rails.start()
// Turbolinks.start()
// ActiveStorage.start()

'use strict';

require("@rails/ujs").start()
//require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

import $, { error } from 'jquery';
window.jQuery = $;
window.$ = $;

require("bootstrap")
require("@nathanvda/cocoon")
require("packs/src/owl.carousel.min.js")

import "@fortawesome/fontawesome-free/js/all.js";

import LocalTime from "local-time"
LocalTime.start()

let Owl, formError;

$(document).ready(() => {
  Owl = $('.owl-carousel');
  formError = $('#form-error');
})
$(document).ready(initOwlCarousel);
$(document).ready(initFormValidation);
$(document).ready(addEventListeners);

function addEventListeners() {
  $('.btn-outline-secondary').click(previousSlide);
  $('.btn-outline-primary').click(nextSlide);

  $(':input[type="radio"]').each(function() {
    $(this).change(nextSlide);
  })
}

function initOwlCarousel() {
  Owl.owlCarousel({
    items: 1
  })
}

function initFormValidation() {
  // Fetch all the forms we want to apply custom Bootstrap validation styles to
  const forms = document.querySelectorAll('.needs-validation');

  // Loop over them and prevent submission
  Array.prototype.slice.call(forms)
    .forEach(function (form) {
      form.addEventListener('submit', function (event) {
        // Check if at least one option of multiple-choice question was selected

        if (!form.checkValidity()) {
          event.preventDefault();
          event.stopPropagation();

          // Move Owl Carousel to the first slide with error
          const errorSlides = $('.item').has('.form-check-input:invalid');

          if (errorSlides[0]) {
            Owl.trigger('to.owl.carousel', [errorSlides[0].dataset.index, 100]);

            formError.text('Please, answer this question.');
            formError.show();
          }
        }

        form.classList.add('was-validated');
      }, false)
    })
}

function previousSlide() {
  Owl.trigger('prev.owl.carousel');
  clearErrorMessage();
}

function nextSlide() {
  Owl.trigger('next.owl.carousel');
  clearErrorMessage();
}

function clearErrorMessage() {
  formError.hide();
  formError.text('');
}