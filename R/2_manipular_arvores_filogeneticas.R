### Como manipular árvores filognéticas?

### Início:---------------------------------------------------------------------

# pacotes necessários:
library(ape)

# Como carregar um árvore filogenética no R? -----------------------------------
# A função 'read.tree()' lê árvores no formato (Newick)
arvore <- read.tree("filogenia/arvore.tre")

# Confira se a árvore foi carregada corretamente (número de espécies,
# número de nós, nome das espécies, se a árvore é enraizada e se
# possui informações sobre o comprimento dos ramos)
arvore

# Como visualizar a árvore (básico)---------------------------------------------
plot(arvore, cex = .5)                # cex regula o tamanho da fonte 
plot(arvore, show.tip.label = F)      # esconde os nomes as espécies
plot(arvore, show.node.label = T,     # mostra o nome dos nós (nodes)
     show.tip.label = F, cex = .7)
plot(arvore, type = "fan", cex = .5)  # Plota uma árvore circular
###-----------------------------------------------------------------------------

### Características da sua árvore:----------------------------------------------
# Veja a lista de espécies da sua árvore:
arvore$tip.label

# Veja o comprimento dos ramos:
arvore$edge.length

# Como verificar se a árvore é ultramétrica?
is.ultrametric(arvore)

# Como verificar se a árvore é enraizada?
is.rooted(arvore)

# Se a árvore não tiver nome nos nós (nodes), utilize essa função para criar
# nomes para os nós
arvore$node.label
arvore <- makeNodeLabel(arvore) 

# Veja que agora os nós possuem um nome:
arvore$node.label

# Existem politomias na minha árvore?
# Se a sua árvore não tiver politomias, o número de nós dever ser igual ao
# número de espécies -1. Se isso não ocorrer, sua árvore possue politomias:
Nnode <- arvore$Nnode               # Número de nós
Nsp   <- length(arvore$tip.label)   # Número de espécies
# Existem politomias na minha árvore?
Nnode == (Nsp -1)

# Quantas politomias existem na minha árvore?
(Nsp -1) - Nnode
###-----------------------------------------------------------------------------

### Como remover uma/várias espécies da árvore? --------------------------------
drop.tip(arvore, arvore$tip.label[1])   # remove a primeira espécies da árvore
drop.tip(arvore, arvore$tip.label[1:5]) # remove as cinco primeiras espécies
drop.tip(arvore, "Tringa_glareola")     # remove a espécies "Tringa_glareola"

# Como cortar um node da árvore (nó)?
extract.clade(phy = arvore, node = "Node61") # remove o nó 61

# Depois de remover as espécies que deseja, você pode salvar a árvore em um objeto:
arvore2 <- drop.tip(arvore, c("Tringa_glareola", "Haematopus_ostralegus"))
arvore2   # perceba que agora a árvore possui 69 espécies (em vez de 71)

# Para exportar a árvore em formato Newwick, utilize a função 'write.tree()'
write.tree(phy = arvore2, file = "arvore2.tre")

# para excluir o arquivo
unlink("arvore2.tre")

### Como criar um árvore filogenética manualmente?------------------------------
### Formato Newwick: 
sp <- "((specie_A:5, specie_B:5):15, especie_C:20);"

### Exporta a árvore:
cat(sp, file = "exemplo.tre", sep = "\n")
### Carrega a árvore:
arv.exemplo <- read.tree("exemplo.tre")
arv.exemplo
plot(arv.exemplo)

### Deleta arvore do diretório:
unlink("exemplo.tre")

### FIM-------------------------------------------------------------------------

