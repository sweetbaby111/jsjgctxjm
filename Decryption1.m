function DecImage=Decryption1(EncImage,KeyImage,KeyDecimal,KeyFeature,M,N)
% 
%     I=PlainImg;
%     b1 = 1;
%     b2 = 1;
%     b3 = 2;
%     b4 = 2;
%     [y, K] = getSeq(I, b1, b2, b3, b4);
%       DecbitImage = jpd_decrypt(EncImage,y);
%       DecbitImage = double(DecbitImage);
% 
    DecbitImage = PlaneDecryption(EncImage);
    DecbitImage = double(DecbitImage);

    Encoded_EnImg=EncodeImageinto4Subcell(M,N,DecbitImage);
   
    EncodedDNA_EnImg=EncodedImageIntoDNASeqence(M,N,Encoded_EnImg,KeyDecimal,KeyFeature);
   
    DifImgDNA=DiffusionDNA(EncodedDNA_EnImg,KeyImage,KeyDecimal,KeyFeature,M,N,'Decryption');
    
    PerImageDNA = PermutationDNA(DifImgDNA,KeyDecimal,KeyFeature,M,N,'Decryption');

    DecImage=DecodingDNAImage(M,N, PerImageDNA,KeyDecimal,KeyFeature);

end