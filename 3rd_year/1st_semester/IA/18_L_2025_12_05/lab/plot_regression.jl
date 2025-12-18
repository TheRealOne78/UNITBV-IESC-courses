using CSV
using DataFrames
using Plots

println("Loading data...")

# Load regression data
regression_data = CSV.read("regression_data.csv", DataFrame)

println("Creating visualization...")

# Main plot: Regression line with data points
p = scatter(
    regression_data.x, 
    regression_data.y_actual,
    xlabel="Years of Experience",
    ylabel="Salary",
    title="Linear Regression",
    markersize=8,
    markercolor=:blue,
    markerstrokewidth=2,
    legend=:topleft,
    size=(1000, 700)
)

plot!(
    p,
    regression_data.x,
    regression_data.y_predicted,
    linewidth=3,
    linecolor=:red,
    linestyle=:solid
)

plot!(p, grid=true, gridstyle=:dot, gridalpha=0.3)

display(p)
# keep process alive
while true
    sleep(0.1)
end
