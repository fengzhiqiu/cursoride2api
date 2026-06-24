FROM node:20-alpine

WORKDIR /app

# 先复制依赖文件，利用 Docker layer 缓存
COPY package.json ./
RUN npm install --omit=dev

# 复制源码
COPY server.js ./
COPY src/ ./src/

# 默认端口
EXPOSE 3000

# 健康检查
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD wget -q --spider http://localhost:3000/health || exit 1

CMD ["node", "server.js"]
