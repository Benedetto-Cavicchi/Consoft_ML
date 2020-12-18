source("./r_files/flatten_HTML.r")



library(plotly)
library(igraph)
library(readr)
#values = read_csv("C:/Users/giulio.olivero/Downloads/Dataset1-Media-Example-EDGES.csv")

Values = read_csv("C:/Users/giulio.olivero/Downloads/df_graph.csv")
edges <- read_csv("C:/Users/giulio.olivero/Downloads/Dataset1-Media-Example-EDGES.csv")
nodes <- read_csv("C:/Users/giulio.olivero/Downloads/Dataset1-Media-Example-NODES.csv")

#dataset <- data.frame(Values)
#edges <- cbind(dataset$from, dataset$to)
#nodes <-cbind(dataset$media)

edgelist <- cbind(edges$from, edges$to)


net <- graph_from_edgelist(edgelist, directed = TRUE)



G <- upgrade_graph(net)
L <- layout.circle(G)



vs <- V(G)
es <- as.data.frame(get.edgelist(G))





Nv <- length(vs) #numero di nodi
Ne <- length(es[1]$V1) #numero di edges





library(plotly)





Xn <- L[,1]
Yn <- L[,2]





network <- plot_ly(x = ~Xn, y = ~Yn, mode = "markers", text = nodes$media, hoverinfo = "text", size = nodes$audience.size*5, color = nodes$media.type)#, size = as.numeric(nodes[,1]))





edge_shapes <- list()
for(i in 1:Ne) {
  v0 <- es[i,]$V1
  v1 <- es[i,]$V2
  
  edge_shape = list(
    type = "line",
    line = list(color = "#030303", width = 0.5),
    x0 = Xn[v0],
    y0 = Yn[v0],
    x1 = Xn[v1],
    y1 = Yn[v1]
  )
  
  edge_shapes[[i]] <- edge_shape
}







axis <- list(title = "", showgrid = FALSE, showticklabels = F, zeroline = FALSE)





fig <- layout(
  network,
  title = '',
  shapes = edge_shapes,
  xaxis = axis,
  yaxis = axis
)





fig





############# Create and save widget ###############
p = fig;
internalSaveWidget(p, 'out.html');