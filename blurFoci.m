function blurred=blurFoci(myImageInput, fociSettings)

blurred=imgaussfilt(histeq(myImageInput),fociSettings.radius);

