# Stage 1: Build the application
FROM oven/bun:latest AS builder

WORKDIR /app

# Copy package.json and package-lock.json (or bun.lockb) to install dependencies
COPY package.json bun.lockb ./

# Install dependencies
RUN bun install
RUN bun update

# Copy the rest of the application code
COPY . .

# Run the build command
# (Optional) Use --minify command to minify the size of output file
RUN bun build ./src/main.ts --compile --target bun --outfile=nest-bun-docker

# Stage 2: Create the runtime image
# (Optional) Use either oven/bun:slim or oven/bun:alpine to reduce the docker-image size
FROM oven/bun:latest

WORKDIR /app

# Copy only the necessary files from the builder stage
COPY --from=builder /app/nest-bun-docker ./

# Expose the port your app runs on (only needed if you want to run it standalone)
# If using docker-compose, you can define ports in the docker-compose.yml file instead.
EXPOSE 3000

# Use the compiled application
CMD [ "./nest-bun-docker" ]
