# Regularized Non-negative Spectral Embedding for Clustering
This is the code of the proposed clustering algorithm of paper &lt;Regularized Non-negative Spectral Embedding for Clustering>.

There are 5 matlab files here.
The file `ClusteringMeasure.m` outputs the acc, NMI and purity of the clustering result.
Save datasets in a dimension$$\times$$Number double matrix and label in an 1$$\times$$Number vector. And put the `.mat` file in `test_data`. The `data_fetch.m` file will fetch the data automatically.
The file `Example.m` shows that how to use the code.
The file `RNSE.m` is the code of RNSE and the fuction to construct W for it.
`use_single_rnse` file call the `data_fetch.m` file to fetch data for `RNSE.m` and call the `ClusteringMeasure.m` to calculate the acc, NMI and purity of the clustering result.

