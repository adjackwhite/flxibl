import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  const prevProfessions = JSON.parse($('#profession-filter')[0].dataset.selected) || []
  console.log(prevProfessions)
  $('#profession-filter').val(prevProfessions).trigger('change');
  $('#profession-filter').select2({
    placeholder: "Filter",
    allowClear: true,
  });

  const prevSkills = JSON.parse($('#skill-filter')[0].dataset.selected) || []
  $('#skill-filter').val(prevSkills).trigger('change');
  $('#skill-filter').select2({
    placeholder: "Filter",
    allowClear: true,
  });

  const prevLocation = JSON.parse($('#location-filter')[0].dataset.selected) || []
  $('#location-filter').val(prevLocation).trigger('change');
  $('#location-filter').select2({
    placeholder: "Filter",
    allowClear: true,
  });

  $('.select2').select2({
    placeholder: "Filter",
    allowClear: true,
  });
};

export { initSelect2 };
