presidential |>
  # add id of the president starting from 34
  mutate(id = 33 + row_number()) |> 
  # map start, id, and party to x, y, and colour
  ggplot(aes(start, id, colour = party)) + 
  # add a point marking the start of the term
  geom_point() + 
  # add a segment with length the duration of the presidential term
  geom_segment(aes(xend = end, yend = id)) + 
  # set manually the colors (Republican = red, Democratic = blue)
  scale_colour_manual(values = c(Republican = "red", Democratic = "blue")) + 
                        # add black and white theme    
                        theme_bw()