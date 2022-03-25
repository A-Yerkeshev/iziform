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
        if (!form.checkValidity()) {
          event.preventDefault();
          event.stopPropagation();

          // Indicate failed validation based on form id
          switch ($(form).attr('id')) {
            case 'response-form':
              const errorSlides = $('.item').has(':invalid');

              if (errorSlides[0]) {
                // Move Owl Carousel to the first slide with error
                Owl.trigger('to.owl.carousel', [errorSlides[0].dataset.index, 100]);
                formError.text('Please, answer this question.');
              }
              break;
            case 'new-form-form':
              if ($('#form_name').val().trim() === '') {
                formError.text('Form name cannot be blank.');
              } else {
                formError.text('Question cannot be blank.');
              }

              break;
            default:
          }

          formError.removeClass('d-none');
        }

        $(form).addClass('was-validated');
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
  formError.addClass('d-none');
  formError.text('');
}

function groupCheckboxes(checkboxes) {
  const groups = {};

  checkboxes.each(function() {
    const groupId = $(this).attr('id').replace('response_content_', '').slice(0, -1);

    groups.hasOwnProperty(groupId) ? groups[groupId].push($(this)) : groups[groupId] = [$(this)];
  })

  return [Object.values(groups)];
}

// Not working code for multiple-choice questions validation
//   // Check if at least one option of multiple-choice question was selected
//   const allCheckboxes = $(':input[type="checkbox"]');
//   const checkboxGroups = groupCheckboxes(allCheckboxes);

//   checkboxGroups.forEach((group) => {
//     let atLeastOne = false;

//     for (let i=0; i<group.length; i++) {
//       if (group[i].checked) {
//         atLeastOne = true;
//         break;
//       }
//     }

//     // If no option was selected - mark all checkboxes as required
//     if (!atLeastOne) {
//       valid = false;

//       group.forEach((checkbox) => {
//         $(checkbox).removeClass(':valid');
//         $(checkbox).addClass(':invalid');
//       })
//     }
//   })
