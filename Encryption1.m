function EncImage=Encryption1(PlainImg,KeyImage,KeyDecimal,KeyFeature,M,N) 
      
    Encoded_DifImg=EncodeImageinto4Subcell(M,N,PlainImg);
   
    EncodedDNA_DifImg=EncodedImageIntoDNASeqence(M, N, Encoded_DifImg, KeyDecimal, KeyFeature);
 
    EncodedDNA_PerImage = PermutationDNA(EncodedDNA_DifImg,KeyDecimal,KeyFeature,M,N,'Encryption');
    
    DifImgDNA=DiffusionDNA(EncodedDNA_PerImage,KeyImage,KeyDecimal,KeyFeature,M,N,'Encryption');
    
    EncDNAImage=DecodingDNAImage(M,N,DifImgDNA,KeyDecimal,KeyFeature);
  
%     I=PlainImg;
%     b1 = 1;
%     b2 = 1;
%     b3 = 2;
%     b4 = 2;
%     [y, K] = getSeq(I, b1, b2, b3, b4);
%     P=EncDNAImage;
%     EncImage=jpd_encrypt(P, y);
%     EncImage = double(EncImage);
    EncImage = PlaneEncryption(EncDNAImage);
    EncImage = double(EncImage);
    
end
