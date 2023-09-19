% Spectral Clustering on our Data
data=load('corrData.dat');
[r,~]=size(data);


% Calculating Euclidean Distance Matrix
distGraph=squareform(pdist(data, 'squaredeuclidean'));

%Calculating Guassian Similarity Matrix using sigma=0.5
simGraph=exp(-distGraph.^2 ./ (2*0.5^2));

%Number of Clusters 
clustersNo = 10;

%For reproducibility
% rng('default');

% Type of Spectral Clustering(1,2 or 3)
clusteringType = 3;

% Getting nCIndex [nCIndex means ith(i varies from 1 to 2376) vector 
% is assigned jth(j varies from 1 to clustersNo) cluster]
nCIndex = SpectralClustering(simGraph, clustersNo, clusteringType);

%Calculating silhouette index of clustering (Spectral Clustering)
nsilhoeutte=silhouette(data,nCIndex,'SqEuclidean');
sil=mean(nsilhoeutte);

clusterCount = zeros(clustersNo,1);
sampleClusterCount = zeros(clustersNo,1);
for i = 1:r
    clusterCount(nCIndex(i,1)) = clusterCount(nCIndex(i,1)) + 1;
end
 bar(clusterCount);
 text(1:clustersNo,clusterCount,num2str(clusterCount),'vert','bottom','horiz','center');
 xlabel('Cluster Number');
 ylabel('Number of Genotypes')
 box off;


% Getting nCIndex using K-means Clustering
% kncindex = kmeans(data,clustersNo);

%Calculating silhouette index of clustering (K-means) for Comparison
% knsilhoutte=silhouette(data,kncindex,'Euclidean');
% ksil=mean(knsilhoutte);

%for Calculating Dunn Index (if required)
% dunn=dunns(clustersNo,distGraph,ncindex);
        
