scenarios = ["good", "neutral", "bad"]
crops = ["wheat", "corn", "sugar"]
planting_cost = Dict(
    "wheat" => 150,
    "corn" => 230,
    "sugar" => 260
)
sale_price = Dict(
    "wheat" => 170,
    "corn" => 150,
    "sugar" => 36
)
feed_requirement = Dict(
    "wheat" => 200,
    "corn" => 240,
    "sugar" => 0
)
sugar_threshold = 6000
sugar_second_price = 10

yield = Dict(
    ("wheat", "good") => 3,
    ("wheat", "neutral") => 2.5,
    ("wheat", "bad") => 2,
    ("corn", "good") => 3.6,
    ("corn", "neutral") => 3,
    ("corn", "bad") => 2.4,
    ("sugar", "good") => 24,
    ("sugar", "neutral") => 20,
    ("sugar", "bad") => 16
)

purchase_multiplier = 1.4
land_size = 500