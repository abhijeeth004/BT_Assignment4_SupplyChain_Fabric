'use strict';
const { Contract } = require('fabric-contract-api');

class ProductContract extends Contract {
  async CreateProduct(ctx, productID, owner, metadataJson) {
    const exists = await ctx.stub.getState(productID);
    if (exists && exists.length) throw new Error('Product already exists');
    const product = { productID, owner, metadata: JSON.parse(metadataJson||'{}'), status:'CREATED' };
    await ctx.stub.putState(productID, Buffer.from(JSON.stringify(product)));
    return JSON.stringify(product);
  }

  async TransferShipment(ctx, productID, newOwner, eventMetaJson) {
    const buf = await ctx.stub.getState(productID);
    if (!buf || !buf.length) throw new Error('No such product');
    const p = JSON.parse(buf.toString());
    p.owner = newOwner;
    p.status = 'IN_TRANSIT';
    p.history = p.history || [];
    p.history.push({ event:'TRANSFER', to:newOwner, meta: JSON.parse(eventMetaJson||'{}') });
    await ctx.stub.putState(productID, Buffer.from(JSON.stringify(p)));
    return JSON.stringify(p);
  }

  async ReceiveProduct(ctx, productID, receiver) {
    const buf = await ctx.stub.getState(productID);
    if (!buf || !buf.length) throw new Error('No such product');
    const p = JSON.parse(buf.toString());
    p.owner = receiver;
    p.status = 'DELIVERED';
    p.history = p.history || [];
    p.history.push({ event:'RECEIPT', by:receiver });
    await ctx.stub.putState(productID, Buffer.from(JSON.stringify(p)));
    return JSON.stringify(p);
  }

  async QueryProduct(ctx, productID) {
    const buf = await ctx.stub.getState(productID);
    if (!buf || !buf.length) throw new Error('No such product');
    return buf.toString();
  }
}

module.exports = ProductContract;
