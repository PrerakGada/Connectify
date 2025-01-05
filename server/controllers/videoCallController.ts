import { Request, Response } from 'express';
import { RtcTokenBuilder, RtcRole } from 'agora-access-token';
import dotenv from 'dotenv';

dotenv.config();

const APP_ID = process.env.AGORA_APP_ID;
const APP_CERTIFICATE = process.env.AGORA_APP_CERTIFICATE;

export const generateToken = (req: Request, res: Response) => {
  try {
    const { channelName, uid } = req.body;

    if (!channelName || !uid) {
      return res.status(400).json({
        success: false,
        message: 'Channel name and uid are required',
      });
    }
    if (!APP_ID || !APP_CERTIFICATE) {
      return res.status(500).json({
        success: false,
        message: 'Agora credentials not configured',
      });
    }

    const currentTimestamp = Math.floor(Date.now() / 1000);
    const expirationTimestamp = currentTimestamp + 3600;

    const token = RtcTokenBuilder.buildTokenWithUid(
      APP_ID,
      APP_CERTIFICATE,
      channelName,
      uid,
      RtcRole.PUBLISHER,
      expirationTimestamp
    );

    res.json({
      success: true,
      token,
      appId: APP_ID,
    });
  } catch (error) {
    console.error('Error generating token:', error);
    res.status(500).json({
      success: false,
      message: 'Error generating token',
    });
  }
}; 