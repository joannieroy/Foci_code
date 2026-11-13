function outIm=replaceBoundingBox(imIn, bbox, bboxImage)

outIm=imIn;

x1 = ceil(bbox(1));
x2 = x1 + bbox(3);
y1 = ceil(bbox(2));
y2 = y1 + bbox(4);

if y2>size(imIn, 1)
    y2=y2-1;
end
if x2>size(imIn, 2)
    x2=x2-1;
end

outIm(y1:y2, x1:x2) = bboxImage; 


