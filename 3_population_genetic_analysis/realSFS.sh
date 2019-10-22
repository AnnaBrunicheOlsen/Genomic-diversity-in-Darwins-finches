read_realSFS <- function(filepath){
  df = read.csv(filepath, sep =' ', header = FALSE)
  colnames(df) = c('A', 'D', 'G', 'B', 'E', 'H', 'C', 'F', 'I', 'drop')
  df['drop'] = NULL
  df['nSites'] = as.integer(rowSums(df))
  
  df['HETHET'] = df['E']
  df['IBS0'] = df['C'] + df['G']
  df['IBS1'] = df['B'] + df['D'] + df['F'] + df['H']
  df['IBS2'] = df['A'] + df['E'] + df['I']
  df['fracIBS0'] = df['IBS0'] / df['nSites']
  df['fracIBS1'] = df['IBS1'] / df['nSites']
  df['fracIBS2'] = df['IBS2'] / df['nSites']
  df['fracHETHET'] = df['E'] / df['nSites']
  
  # the derived stats 
  df['R0'] = df['IBS0'] / df['HETHET']
  df['R1'] = df['HETHET'] / (df['IBS0'] +  df['IBS1'])
  # KING-robust kinship
  df['Kin'] = (df['HETHET'] - 2*(df['IBS0'])) / (df['IBS1'] + 2*df['HETHET'])
  df['Fst'] = (2*df['IBS0'] - df['HETHET']) / (2*df['IBS0'] + df['IBS1'] + df['HETHET'])  
  return(df)
}
