# Barplot ----
### Pseudo-Data
x <- c("1","2","3","4","5")
y.fix <- rep(20,5)
y.opp <- c(10,25,45,70,100)

## Plotting
png(file = "./Opportunitätskosten.png")
	barplot((y.fix + y.opp),
		axes = 0,
		horiz = FALSE,
		col = "white",
		border = "grey40",
		width = 5,
		xlim = c(0,55),
		ylim = c(0,130),
		legend.text = c("Fixkosten","Opportunitätskosten","Gesamtkosten"),
		args.legend = list(bty = "n", fill = c("grey40","white","red")),
		xlab = "Bildungsabschlüsse",
		ylab = "Kosten der Bildung",
		names.arg = c("1.PS","2.SS","3.BS","4.MS","5.P"))
	barplot(y.fix,
		horiz = FALSE,
		axes = 0,
		col = "grey40",
		border = "grey40",
		width = 5,
		xlim = c(0,55),
		ylim = c(0,130),
		legend.text = c("1. primäre Schulbildung","2. sekundäre Schulbildung","3. Bachelor-Studium","4. Master-Studium","5. Promotion"),
		args.legend = list(bty = "n", fill = NA, border = NA, yjust = 4.5),
		add = TRUE)
	lines(y = c(20,(y.opp + y.fix),125),
    	x = c(0,4,10,16,22,28,29),
        type = "l",
        col = "red",
        lwd = 5)
dev.off()

# Plot ----
## Pseudo-Data
x <- seq(from = 1, to = 50, by = 1)
y.opp.2 <- 0.08*x
y.inc.2 <- log(x)

## Plotting
png(file = "./Opportunitätskosten2.png")
	plot(y.opp.2,
		axes = 0,
		col = "black",
		xlab = "Bildungsgrad",
		ylab = "Kosten der Bildung / Lohnhöhe",
		type = "l",
		lwd = 3)
	lines(y.inc.2,
      	col = "blue",
      	type = "l",
      	lwd = 3)
	legend(x = 15, y = 0.5,
       legend = c("Opportunitätskosten für nächste Bildungseinheit","Lohnhöhe bei nächster Bildungseinheit"),
       bty = "n",
       fill = c("black","blue"))
dev.off()