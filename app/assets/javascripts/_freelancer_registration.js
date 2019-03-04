function _freelancerRegistrationInit(){
    bindCloudinaryElement();
    var public_id = $('#freelancer_profile_photo').data("public-id");
    renderProfileImagePreview(public_id);
    taggifyInput();
    bindScrollFunctionToForm();
}